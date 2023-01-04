# Deploy New CloudTrail using existing KMS key

This example creates a new CloudTrail in an AWS account with almost all of the required resources, an existing KMS key must be supplied.

## Inputs

| Name                   | Description                                           | Type   |
| ---------------------- | ----------------------------------------------------- | ------ |
| `bucket_force_destroy` | Force destroy bucket (Required when bucket not empty) | `bool` |
| `bucket_sse_key_arn` | The ARN of the KMS encryption key to be used for S3 | `string` |
| `sns_topic_encryption_key_arn` | The ARN of an existing KMS encryption key to be used for SNS | `string` |
| `sqs_encryption_key_arn` | The ARN of the KMS encryption key to be used for SQS | `string` |

## Sample Code

```hcl
provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

resource "aws_kms_key" "lacework_kms_key" {
  description  = "A KMS key used to encrypt CloudTrail logs which are monitored by Lacework"
  policy       = data.aws_iam_policy_document.kms_key_policy.json
}

module "aws_cloudtrail" {
  source = ">= 2.3.2"

  bucket_force_destroy         = true
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

```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform).
