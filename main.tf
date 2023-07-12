locals {
  trimmed_bucket_arn = var.use_existing_cloudtrail ? trimsuffix(var.bucket_arn, "/") : ""
  bucket_arn         = var.use_existing_cloudtrail ? local.trimmed_bucket_arn : aws_s3_bucket.cloudtrail_bucket[0].arn
  split_bucket_arn   = var.use_existing_cloudtrail ? split(":", local.trimmed_bucket_arn) : []
  bucket_name        = var.use_existing_cloudtrail ? element(local.split_bucket_arn, (length(local.split_bucket_arn) - 1)) : (length(var.bucket_name) > 0 ? var.bucket_name : "${var.prefix}-bucket-${random_id.uniq.hex}")
  log_bucket_name    = length(var.log_bucket_name) > 0 ? var.log_bucket_name : "${local.bucket_name}-access-logs"
  create_sns_topic = var.use_s3_bucket_notification ? var.s3_notification_type == "SNS" : (
    (var.use_existing_cloudtrail && var.use_existing_sns_topic) ? false : true
  )
  sns_topic_name = length(var.sns_topic_name) > 0 ? var.sns_topic_name : "${var.prefix}-sns-${random_id.uniq.hex}"
  sns_topic_arn = (var.use_existing_cloudtrail && var.use_existing_sns_topic) ? var.sns_topic_arn : (
    local.create_sns_topic ? aws_sns_topic.lacework_cloudtrail_sns_topic[0].arn : ""
  )
  sns_topic_key_arn = var.sns_topic_encryption_enabled ? (length(var.sns_topic_encryption_key_arn) > 0 ? var.sns_topic_encryption_key_arn : aws_kms_key.lacework_kms_key[0].arn) : ""
  sqs_queue_name    = length(var.sqs_queue_name) > 0 ? var.sqs_queue_name : "${var.prefix}-sqs-${random_id.uniq.hex}"
  sqs_queue_key_arn = var.sqs_encryption_enabled ? (length(var.sqs_encryption_key_arn) > 0 ? var.sqs_encryption_key_arn : aws_kms_key.lacework_kms_key[0].arn) : ""
  sqs_source_arn    = (var.use_s3_bucket_notification && var.s3_notification_type == "SQS") ? local.bucket_arn : local.sns_topic_arn
  create_kms_key = (
    (!var.use_existing_cloudtrail ? length(var.bucket_sse_key_arn) == 0 : false)
    || (var.sns_topic_encryption_enabled ? length(var.sns_topic_encryption_key_arn) == 0 : false)
    || (var.sqs_encryption_enabled ? length(var.sqs_encryption_key_arn) == 0 : false)
  ) ? 1 : 0
  cross_account_policy_name = (
    length(var.cross_account_policy_name) > 0 ? var.cross_account_policy_name : "${var.prefix}-cross-acct-policy-${random_id.uniq.hex}"
  )
  iam_role_arn         = module.lacework_ct_iam_role.created ? module.lacework_ct_iam_role.arn : var.iam_role_arn
  iam_role_external_id = module.lacework_ct_iam_role.created ? module.lacework_ct_iam_role.external_id : var.iam_role_external_id
  iam_role_name = var.use_existing_iam_role ? var.iam_role_name : (
    length(var.iam_role_name) > 0 ? var.iam_role_name : "${var.prefix}-iam-${random_id.uniq.hex}"
  )
  lacework_integration_guid = var.create_lacework_integration && length(var.sqs_queues) == 0 ? lacework_integration_aws_ct.default[0].id : ""
  mfa_delete                = var.bucket_versioning_enabled && var.bucket_enable_mfa_delete ? "Enabled" : "Disabled"
  bucket_encryption_enabled = var.bucket_encryption_enabled && length(local.bucket_sse_key_arn) > 0
  bucket_versioning_enabled = var.bucket_versioning_enabled ? "Enabled" : "Suspended"
  bucket_sse_key_arn        = var.use_existing_kms_key ? var.bucket_sse_key_arn : ((var.use_existing_cloudtrail || length(var.bucket_sse_key_arn) > 0) ? var.bucket_sse_key_arn : aws_kms_key.lacework_kms_key[0].arn)
}

resource "random_id" "uniq" {
  byte_length = 4
}

#tfsec:ignore:aws-kms-auto-rotate-keys customer has option of enabling
resource "aws_kms_key" "lacework_kms_key" {
  count                   = var.use_existing_kms_key ? 0 : local.create_kms_key
  description             = "A KMS key used to encrypt CloudTrail logs which are monitored by Lacework"
  deletion_window_in_days = var.kms_key_deletion_days
  multi_region            = var.kms_key_multi_region
  tags                    = var.tags
  policy                  = data.aws_iam_policy_document.kms_key_policy.json
  enable_key_rotation     = var.kms_key_rotation
}

resource "aws_cloudtrail" "lacework_cloudtrail" {
  count                      = var.use_existing_cloudtrail ? 0 : 1
  name                       = var.cloudtrail_name
  is_multi_region_trail      = true
  is_organization_trail      = var.is_organization_trail
  s3_bucket_name             = local.bucket_name
  kms_key_id                 = local.bucket_sse_key_arn
  sns_topic_name             = var.use_s3_bucket_notification ? null : local.sns_topic_arn
  tags                       = var.tags
  enable_log_file_validation = var.enable_log_file_validation

  dynamic "event_selector" {
    for_each = var.enable_cloudtrail_s3_management_events ? [1] : []
    # If enable_cloudtrail_s3_management_events is enabled, create one of the below
    # blocks. Otherwise, create zero of the below blocks.
    content {
      read_write_type           = "All"
      include_management_events = true
      
      data_resource {
        type   = "AWS::S3::Object"
        values = ["${aws_s3_bucket.cloudtrail_bucket[0].arn}/*"]
      }
    }
  }
  depends_on                 = [aws_s3_bucket.cloudtrail_bucket]
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  count         = var.use_existing_cloudtrail ? 0 : 1
  bucket        = local.bucket_name
  force_destroy = var.bucket_force_destroy
  tags          = var.tags
}


resource "aws_s3_bucket_public_access_block" "cloudtrail_bucket_access" {
  count                   = var.use_existing_cloudtrail ? 0 : 1
  bucket                  = aws_s3_bucket.cloudtrail_bucket[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "cloudtrail_bucket_ownership_controls" {
  count  = var.use_existing_cloudtrail ? 0 : 1
  bucket = aws_s3_bucket.cloudtrail_bucket[0].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

// v4 s3 bucket changes
resource "aws_s3_bucket_logging" "cloudtrail_bucket_logging" {
  count         = var.bucket_logs_enabled && !var.use_existing_cloudtrail ? 1 : 0
  bucket        = aws_s3_bucket.cloudtrail_bucket[0].id
  target_bucket = var.use_existing_access_log_bucket ? local.log_bucket_name : aws_s3_bucket.cloudtrail_log_bucket[0].id
  target_prefix = var.access_log_prefix
}

resource "aws_s3_bucket_notification" "cloudtrail_bucket_notification" {
  count  = var.use_s3_bucket_notification ? 1 : 0
  bucket = local.bucket_name

  dynamic "queue" {
    for_each = (var.s3_notification_type == "SQS") ? [1] : []
    content {
      queue_arn     = aws_sqs_queue.lacework_cloudtrail_sqs_queue.arn
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = var.s3_notification_log_prefix
    }
  }

  dynamic "topic" {
    for_each = (var.s3_notification_type == "SNS") ? [1] : []
    content {
      topic_arn     = local.sns_topic_arn
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = var.s3_notification_log_prefix
    }
  }

  depends_on = [
    aws_sns_topic_policy.default,
    aws_sqs_queue_policy.lacework_sqs_queue_policy,
  ]
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  count  = var.use_existing_cloudtrail ? 0 : 1
  bucket = aws_s3_bucket.cloudtrail_bucket[0].id
  policy = data.aws_iam_policy_document.cloudtrail_s3_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_bucket_encryption" {
  count  = var.bucket_encryption_enabled && !var.use_existing_cloudtrail ? 1 : 0
  bucket = aws_s3_bucket.cloudtrail_bucket[0].id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.bucket_sse_key_arn
      sse_algorithm     = var.bucket_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_versioning" "cloudtrail_bucket_versioning" {
  count  = var.bucket_logs_enabled && !var.use_existing_cloudtrail ? 1 : 0
  bucket = aws_s3_bucket.cloudtrail_bucket[0].id
  versioning_configuration {
    status     = local.bucket_versioning_enabled
    mfa_delete = local.mfa_delete
  }
}


data "aws_iam_policy_document" "cloudtrail_log_policy" {
  version = "2012-10-17"

  statement {
    sid     = "ForceSSLOnlyAccess"
    actions = ["s3:*"]
    effect  = "Deny"

    resources = [
      "arn:aws:s3:::${local.log_bucket_name}",
      "arn:aws:s3:::${local.log_bucket_name}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_log_bucket_policy" {
  count  = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket = aws_s3_bucket.cloudtrail_log_bucket[0].id
  policy = data.aws_iam_policy_document.cloudtrail_log_policy.json
}

resource "aws_s3_bucket" "cloudtrail_log_bucket" {
  count         = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket        = local.log_bucket_name
  force_destroy = var.bucket_force_destroy
  tags          = var.tags
}


resource "aws_s3_bucket_public_access_block" "cloudtrail_log_bucket_access" {
  count  = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket                  = aws_s3_bucket.cloudtrail_log_bucket[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "cloudtrail_log_bucket_ownership_controls" {
  count  = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket = aws_s3_bucket.cloudtrail_log_bucket[0].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

// v4 s3 log bucket changes
resource "aws_s3_bucket_acl" "cloudtrail_log_bucket_acl" {
  count  = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket = aws_s3_bucket.cloudtrail_log_bucket[0].id
  acl    = "log-delivery-write"
  depends_on = [aws_s3_bucket_ownership_controls.cloudtrail_log_bucket_ownership_controls, aws_s3_bucket_ownership_controls.cloudtrail_bucket_ownership_controls]
}

resource "aws_s3_bucket_versioning" "cloudtrail_log_bucket_versioning" {
  count  = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket = aws_s3_bucket.cloudtrail_log_bucket[0].id
  versioning_configuration {
    status     = local.bucket_versioning_enabled
    mfa_delete = local.mfa_delete
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_log_encryption" {
  count  = (var.use_existing_cloudtrail || var.use_existing_access_log_bucket) ? 0 : (var.bucket_logs_enabled ? 1 : 0)
  bucket = aws_s3_bucket.cloudtrail_log_bucket[0].id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.bucket_sse_key_arn
      sse_algorithm     = var.bucket_sse_algorithm
    }
  }
}


# we need the identity of the caller to get their account_id for the s3 bucket
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "kms_key_policy" {
  version = "2012-10-17"

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = (!var.use_existing_cloudtrail && length(var.bucket_sse_key_arn) == 0) || var.sns_topic_encryption_enabled ? [1] : []
    content {
      sid    = "Allow CloudTrail service to encrypt/decrypt"
      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }

      actions   = ["kms:GenerateDataKey*", "kms:Decrypt"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.use_s3_bucket_notification ? [1] : []
    content {
      sid    = "Allow S3 bucket to encrypt/decrypt"
      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["s3.amazonaws.com"]
      }

      condition {
        test     = "ArnEquals"
        variable = "aws:SourceArn"
        values = [
          local.bucket_arn
        ]
      }

      actions   = ["kms:GenerateDataKey*", "kms:Decrypt"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = (!var.use_existing_cloudtrail && length(var.bucket_sse_key_arn) == 0) ? [1] : []
    content {
      sid    = "Allow CloudTrail to describe key"
      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }

      actions   = ["kms:DescribeKey"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = (var.sns_topic_encryption_enabled && length(var.sns_topic_encryption_key_arn) == 0) ? [1] : []
    content {
      sid    = "Allow SNS service to encrypt/decrypt"
      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["sns.amazonaws.com"]
      }

      actions   = ["kms:GenerateDataKey*", "kms:Decrypt"]
      resources = ["*"]
    }
  }

  statement {
    sid    = "Allow principals in the account to decrypt log files"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }
}

data "aws_iam_policy_document" "cloudtrail_s3_policy" {
  version = "2012-10-17"

  statement {
    sid       = "AWSCloudTrailAclCheck20150319"
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${local.bucket_name}"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite20150319"
    actions   = ["s3:PutObject"]
    resources = var.consolidated_trail ? (["arn:aws:s3:::${local.bucket_name}/AWSLogs/*"]) : (["arn:aws:s3:::${local.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"])

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid     = "ForceSSLOnlyAccess"
    actions = ["s3:*"]
    effect  = "Deny"

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
      "arn:aws:s3:::${local.bucket_name}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_sns_topic" "lacework_cloudtrail_sns_topic" {
  count             = local.create_sns_topic ? 1 : 0
  name              = local.sns_topic_name
  tags              = var.tags
  kms_master_key_id = local.sns_topic_key_arn
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count   = local.create_sns_topic ? 1 : 0
  version = "2012-10-17"

  dynamic "statement" {
    for_each = !var.use_s3_bucket_notification ? [1] : []
    content {
      actions   = ["SNS:Publish"]
      sid       = "AWSCloudTrailSNSPolicy20150319"
      resources = [local.sns_topic_arn]

      effect = "Allow"

      dynamic "condition" {
        for_each = !var.consolidated_trail ? [1] : []
        content {
          test     = "StringEquals"
          variable = "AWS:SourceArn"
          values   = ["arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${var.cloudtrail_name}"]
        }
      }

      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }
    }
  }

  dynamic "statement" {
    for_each = (var.use_s3_bucket_notification && var.s3_notification_type == "SNS") ? [1] : []
    content {
      actions   = ["SNS:Publish"]
      sid       = "AllowCloudTrailS3ToPublishMessage"
      resources = [local.sns_topic_arn]

      condition {
        test     = "ArnEquals"
        variable = "aws:SourceArn"
        values = [
          local.bucket_arn
        ]
      }

      principals {
        type        = "Service"
        identifiers = ["s3.amazonaws.com"]
      }
    }
  }
}

resource "aws_sns_topic_policy" "default" {
  count  = local.create_sns_topic ? 1 : 0
  arn    = local.sns_topic_arn
  policy = data.aws_iam_policy_document.sns_topic_policy[0].json
}

resource "aws_sqs_queue" "lacework_cloudtrail_sqs_queue" {
  name              = local.sqs_queue_name
  kms_master_key_id = local.sqs_queue_key_arn
  tags              = var.tags
}

resource "aws_sqs_queue_policy" "lacework_sqs_queue_policy" {
  queue_url = aws_sqs_queue.lacework_cloudtrail_sqs_queue.id
  policy    = <<POLICY
{
	"Version": "2012-10-17",
	"Id": "lacework_sqs_policy_${random_id.uniq.hex}",
	"Statement": [
		{
			"Sid": "AllowLaceworkSNSTopicToSendMessage",
			"Effect": "Allow",
			"Principal": {
				"AWS": "*"
			},
			"Action": "SQS:SendMessage",
			"Resource": "${aws_sqs_queue.lacework_cloudtrail_sqs_queue.arn}",
			"Condition": {
				"ArnEquals": {
					"aws:SourceArn": "${local.sqs_source_arn}"
				}
			}
		}
	]
}
POLICY
}

resource "aws_sns_topic_subscription" "lacework_sns_topic_sub" {
  count     = (var.use_s3_bucket_notification && var.s3_notification_type == "SQS") ? 0 : 1
  topic_arn = local.sns_topic_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.lacework_cloudtrail_sqs_queue.arn
}

data "aws_iam_policy_document" "cross_account_policy" {
  count   = var.use_existing_iam_role_policy ? 0 : 1
  version = "2012-10-17"

  statement {
    sid       = "ReadLogFiles"
    actions   = ["s3:Get*"]
    resources = ["${local.bucket_arn}/*"]
  }

  dynamic "statement" {
    for_each = local.bucket_encryption_enabled && var.bucket_sse_algorithm == "aws:kms" ? [1] : []
    content {
      sid       = "DecryptLogFiles"
      actions   = ["kms:Decrypt"]
      resources = [local.bucket_sse_key_arn]
    }
  }

  dynamic "statement" {
    for_each = var.sqs_encryption_enabled ? [1] : []
    content {
      sid       = "DecryptQueueFiles"
      actions   = ["kms:Decrypt"]
      resources = [local.sqs_queue_key_arn]
    }
  }

  statement {
    sid       = "GetAccountAlias"
    actions   = ["iam:ListAccountAliases"]
    resources = ["*"]
  }

  statement {
    sid       = "ListLogFiles"
    resources = [local.bucket_arn]
    actions   = ["s3:ListBucket"]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["*AWSLogs/"]
    }
  }

  statement {
    sid       = "ConsumeNotifications"
    resources = flatten([var.sqs_queues, [aws_sqs_queue.lacework_cloudtrail_sqs_queue.arn]])
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage"
    ]
  }

  statement {
    sid       = "Debug"
    resources = ["*"]
    actions = [
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetTrailStatus",
      "s3:GetBucketPolicy",
      "s3:GetBucketLocation",
      "sns:GetTopicAttributes",
      "sns:ListSubscriptions",
      "sns:ListTopics"
    ]
  }
}

resource "aws_iam_policy" "cross_account_policy" {
  count       = var.use_existing_iam_role_policy ? 0 : 1
  name        = local.cross_account_policy_name
  description = "A cross account policy to allow Lacework to pull config and cloudtrail"
  policy      = data.aws_iam_policy_document.cross_account_policy[0].json
  tags        = var.tags
}

module "lacework_ct_iam_role" {
  source                  = "lacework/iam-role/aws"
  version                 = "~> 0.3"
  create                  = var.use_existing_iam_role ? false : true
  iam_role_name           = local.iam_role_name
  permission_boundary_arn = var.permission_boundary_arn
  lacework_aws_account_id = var.lacework_aws_account_id
  external_id_length      = var.external_id_length
  tags                    = var.tags
}

resource "aws_iam_role_policy_attachment" "lacework_cross_account_iam_role_policy" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.cross_account_policy[0].arn
  depends_on = [module.lacework_ct_iam_role]
}

# wait for X seconds for things to settle down in the AWS side
# before trying to create the Lacework external integration
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on = [
    aws_iam_role_policy_attachment.lacework_cross_account_iam_role_policy,
    aws_sns_topic_subscription.lacework_sns_topic_sub,
    aws_cloudtrail.lacework_cloudtrail
  ]
}

resource "lacework_integration_aws_ct" "default" {
  // do not create a CT integration if the user provides multiple
  // SQS queues to configure, it means that they want to fan-out
  // with a lambda function that acks like a gateway
  count     = var.create_lacework_integration && length(var.sqs_queues) == 0 ? 1 : 0
  name      = var.lacework_integration_name
  queue_url = aws_sqs_queue.lacework_cloudtrail_sqs_queue.id
  credentials {
    role_arn    = local.iam_role_arn
    external_id = local.iam_role_external_id
  }

  dynamic "org_account_mappings" {
    for_each = var.org_account_mappings
    content {
      default_lacework_account = org_account_mappings.value["default_lacework_account"]

      dynamic "mapping" {
        for_each = org_account_mappings.value["mapping"]
        content {
          lacework_account = mapping.value["lacework_account"]
          aws_accounts     = mapping.value["aws_accounts"]
        }
      }
    }
  }

  depends_on = [time_sleep.wait_time]
}
