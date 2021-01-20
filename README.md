<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-cloudtrail

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-cloudtrail.svg)](https://github.com/lacework/terraform-aws-cloudtrail/releases/)
[![CircleCI status](https://circleci.com/gh/lacework/terraform-aws-cloudtrail.svg?style=shield)](https://circleci.com/gh/lacework/terraform-aws-cloudtrail)

Terraform module for configuring an integration with Lacework and AWS for CloudTrail analysis.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudtrail_name | Name of the CloudTrail | `string` | "lacework-cloudtrail" | no |
| enable_log_file_validation | Specifies whether CloudTrail log file integrity validation is enabled | `bool` | `false` | no |
| bucket_force_destroy | Force destroy bucket (Required when bucket not empty) | `bool` | false | no |
| bucket_name | Name of S3 bucket. Required when setting `use_existing_cloudtrail` to true | `string` | "" | no |
| bucket_arn | The S3 bucket ARN is required only when setting `use_existing_cloudtrail` to true | `string` | "" | no |
| bucket_enable_encryption | Set this to `true` to enable encryption on a created S3 bucket | `bool` | false | no |
| bucket_enable_logs | Set this to `true` to enable access logging on a created S3 bucket | `bool` | false | no |
| bucket_enable_versioning | Set this to `true` to enable access versioning on a created S3 bucket | `bool` | false | no |
| bucket_sse_algorithm | Name of the server-side encryption algorithm to use ("AES256" or "aws:kms") | `string` | AES256 | no |
| bucket_sse_key_arn | The ARN of the KMS encryption key to be used (Required when using "aws:kms") | `string` | "" | no |
| external_id_length | Length of External ID (max 1224) | `number` | 16 | no |
| iam_role_external_id | External ID for IAM Role | `string` | "" | no |
| iam_role_name |  The IAM role name | `string` | "lacework_iam_role" | no |
| lacework_integration_name | The name of the integration in Lacework. | `string` | TF cloudtrail | no |
| log_bucket_name | Name of the S3 bucket for access logs | `string` | "" | no |
| prefix | The prefix that will be use at the beginning of every generated resource | `string` | lacework-ct | no |
| sns_topic_name | SNS topic name. Can be used when generating a new resource or when using an existing resource. | `string` | "" | no |
| sqs_queue_name | SQS queue name. Can be used when generating a new resource or when using an existing resource. | `string` | "" | no |
| sqs_queues | List of SQS queues to configure in the Lacework cross-account policy. | `list(string)` | `[]` | no |
| consolidated_trail | Set this to `true` to configure a consolidated cloudtrail. | `bool` | `false` | no |
| org_account_mappings | Mapping of AWS accounts to Lacework accounts within a Lacework organization. | `list(object)` | `[]` | no |
| use_existing_cloudtrail | Set this to `true` to use an existing cloudtrail. When set to `true` you must provide both the `bucket_name` and `sns_topic_name` | `bool` | `false` | no |
| use_existing_iam_role | Set this to `true` to use an existing IAM role. When set to `true` you must provide both the `iam_role_name` and `iam_role_external_id` | `bool` | `false` | no |
| tags | A map/dictionary of Tags to be assigned to created resources. | `map(string)` | `{}` | no |
| wait_time | Define a custom delay between cloud resource provision and Lacework external integration to avoid errors while things settle down. Use `10s` for 10 seconds, `5m` for 5 minutes. | `string` | `10s` | no |

## Outputs

| Name | Description |
|------|-------------|
| external_id | Dynamically generated External ID configured into the IAM role |
| iam_role_name | IAM Role name generated |
| iam_role_arn | IAM Role ARN |
| bucket_name | S3 Bucket name |
| bucket_arn | S3 Bucket ARN |
| sqs_name | SQS Queue name |
| sqs_arn | SQS Queue ARN |
| sns_arn | SNS Topic ARN |
