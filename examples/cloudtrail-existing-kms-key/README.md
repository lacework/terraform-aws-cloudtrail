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
}

module "aws_cloudtrail" {
  source = "../../"

  bucket_force_destroy         = true
  use_existing_kms_key         = true
  bucket_sse_key_arn           = aws_kms_key.lacework_kms_key.arn
  sns_topic_encryption_key_arn = aws_kms_key.lacework_kms_key.arn
  sqs_encryption_key_arn       = aws_kms_key.lacework_kms_key.arn
}

```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform).
