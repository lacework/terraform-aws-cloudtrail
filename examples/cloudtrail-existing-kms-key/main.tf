provider "aws" {
  region = "us-east-1"
}

provider "lacework" {}

resource "aws_kms_key" "lacework_kms_key" {
  description = "A KMS key used to encrypt CloudTrail logs which are monitored by Lacework"
  policy      = data.aws_iam_policy_document.kms_key_policy.json
}

module "aws_cloudtrail" {
  source = "../../"

  use_existing_kms_key         = true
  bucket_sse_key_arn           = aws_kms_key.lacework_kms_key.arn
  sns_topic_encryption_key_arn = aws_kms_key.lacework_kms_key.arn
  sqs_encryption_key_arn       = aws_kms_key.lacework_kms_key.arn
}

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

  statement {
    sid    = "Allow CloudTrail service to encrypt/decrypt"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["kms:GenerateDataKey*", "kms:Decrypt"]
    resources = ["*"]
  }

  statement {
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
        module.aws_cloudtrail.bucket_arn
      ]
    }

    actions   = ["kms:GenerateDataKey*", "kms:Decrypt"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow CloudTrail to describe key"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow SNS service to encrypt/decrypt"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions   = ["kms:GenerateDataKey*", "kms:Decrypt"]
    resources = ["*"]
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
