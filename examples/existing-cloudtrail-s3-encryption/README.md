# Integrate Existing CloudTrail w/ S3 Object Encryption

In this example we let users pass an existing CloudTrail that is using S3 object encryption with a KMS key, the fields required for this example are:

## Inputs

| Name                       | Description                                                    | Type     |
| -------------------------- | -------------------------------------------------------------- | -------- |
| `use_existing_cloudtrail`  | Set this to `true` to use an existing CloudTrail.              | `bool`   |
| `bucket_arn`               | The S3 bucket ARN configured in the existing CloudTrail.       | `string` |
| `bucket_encryption_enabled` | Set this to `true` to enable encryption on a created S3 bucket | `bool`   |
| `bucket_name`              | The S3 bucket name configured in the existing CloudTrail.      | `string` |
| `bucket_sse_algorithm`     | Name of the server-side encryption algorithm to use            | `string` |
| `bucket_sse_key_arn`       | The ARN of the KMS encryption key to be used                   | `string` |
| `use_existing_sns_topic`   | Set this to `true` to use an existing SNS topic                | `bool`   |
| `sns_topic_arn`            | The SNS topic ARN configured in the existing CloudTrail.       | `string` |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.0"

  # Use an existing CloudTrail
  use_existing_cloudtrail   = true
  bucket_arn                = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_encryption_enabled = true
  bucket_sse_algorithm      = "aws:kms"
  bucket_sse_key_arn        = "arn:aws:kms:us-west-2:123456789012:key/6e2010aa-27e4-49c6-8887-956abc1caeb9"

  # Use an existing SNS Topic
  use_existing_sns_topic = true
  sns_topic_arn          = "arn:aws:sns:us-west-2:123456789012:lacework-ct-sns-8805c0bf"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
