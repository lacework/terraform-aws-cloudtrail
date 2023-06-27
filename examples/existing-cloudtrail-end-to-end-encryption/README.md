# Integrate Existing CloudTrail w/ End-to-End Encryption

In this example we let users pass an existing CloudTrail that is encrypted using a KMS key. We also set the SQS queue to use Server-side Encyption using a specified KMS key. The fields required for this example are:

## Inputs

| Name                           | Description                                                                | Type     |
| ------------------------------ | -------------------------------------------------------------------------- | -------- |
| `use_existing_cloudtrail`      | Set this to `true` to use an existing CloudTrail.                          | `bool`   |
| `bucket_arn`                   | The S3 bucket ARN configured in the existing CloudTrail.                   | `string` |
| `bucket_encryption_enabled`     | Set this to `true` to enable encryption on a created S3 bucket             | `bool`   |
| `bucket_name`                  | The S3 bucket name configured in the existing CloudTrail.                  | `string` |
| `bucket_sse_algorithm`         | Name of the server-side encryption algorithm to use                        | `string` |
| `bucket_sse_key_arn`           | The ARN of the KMS encryption key to be used                               | `string` |
| `use_existing_sns_topic`       | Set this to `true` to use an existing SNS topic                            | `bool`   |
| `sns_topic_arn`                | The SNS topic ARN configured in the existing CloudTrail.                   | `string` |
| `sns_topic_encryption_enabled` | Set this to `false` to disable encryption on a sns topic. Defaults to true | `bool`   |
| `sns_topic_encryption_key_arn` | The ARN of an existing KMS encryption key to be used for SNS               | `string` |
| `sqs_encryption_enabled`       | Set this to `true` to enable server-side encryption on SQS.                | `bool`   |
| `sqs_encryption_key_arn`       | The ARN of the KMS encryption key to be used for SQS                       | `string` |

## KMS Key Permissions

In order for the SNS service to use the KMS key, the CMK key's policy _must_ contain the following statement:

```json
{
  "Effect": "Allow",
  "Principal": {
    "Service": "sns.amazonaws.com"
  },
  "Action": ["kms:GenerateDataKey", "kms:Decrypt"],
  "Resource": "*"
}
```

[AWS Documentation](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-key-management.html#sqs-what-permissions-for-sse)

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"

  # Use an existing CloudTrail
  use_existing_cloudtrail   = true
  bucket_arn                = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_encryption_enabled = true
  bucket_sse_algorithm      = "aws:kms"
  bucket_sse_key_arn        = "arn:aws:kms:us-west-2:123456789012:key/6e2010aa-27e4-49c6-8887-956abc1caeb9"

  # Use an existing SNS Topic
  use_existing_sns_topic       = true
  sns_topic_arn                = "arn:aws:sns:us-west-2:123456789012:lacework-ct-sns-8805c0bf"
  sns_topic_encryption_enabled = true
  sns_topic_encryption_key_arn = "arn:aws:kms:us-west-2:123456789012:key/3387663d-bb4d-4ed3-8479-7316d4350de8"

  # Use encryption for the created SQS queue
  sqs_encryption_enabled = true
  sqs_encryption_key_arn = "arn:aws:kms:us-west-2:123456789012:key/3387663d-bb4d-4ed3-8479-7316d4350de8"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
