<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-cloudtrail

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-cloudtrail.svg)](https://github.com/lacework/terraform-aws-cloudtrail/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

Terraform module for configuring an integration with Lacework and AWS for CloudTrail analysis.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | >~ 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | >~ 2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lacework_ct_iam_role"></a> [lacework\_ct\_iam\_role](#module\_lacework\_ct\_iam\_role) | lacework/iam-role/aws | ~> 0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.lacework_cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_iam_policy.cross_account_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.lacework_cross_account_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.lacework_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.cloudtrail_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.cloudtrail_log_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.cloudtrail_bucket_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_notification.cloudtrail_bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_ownership_controls.cloudtrail_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.cloudtrail_log_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.cloudtrail_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.cloudtrail_log_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.cloudtrail_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.cloudtrail_log_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cloudtrail_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cloudtrail_log_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.cloudtrail_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.cloudtrail_log_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_sns_topic.lacework_cloudtrail_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.lacework_sns_topic_sub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue.lacework_cloudtrail_sqs_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.lacework_sqs_queue_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [lacework_integration_aws_ct.default](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/integration_aws_ct) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.wait_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudtrail_log_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cross_account_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [lacework_metric_module.lwmetrics](https://registry.terraform.io/providers/lacework/lacework/latest/docs/data-sources/metric_module) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_prefix"></a> [access\_log\_prefix](#input\_access\_log\_prefix) | Optional value to specify a key prefix for access log objects for logging S3 bucket | `string` | `"log/"` | no |
| <a name="input_bucket_arn"></a> [bucket\_arn](#input\_bucket\_arn) | The S3 bucket ARN is required when setting use\_existing\_cloudtrail to true | `string` | `""` | no |
| <a name="input_bucket_enable_mfa_delete"></a> [bucket\_enable\_mfa\_delete](#input\_bucket\_enable\_mfa\_delete) | Set this to `true` to require MFA for object deletion (Requires versioning) | `bool` | `false` | no |
| <a name="input_bucket_encryption_enabled"></a> [bucket\_encryption\_enabled](#input\_bucket\_encryption\_enabled) | Set this to `true` to enable encryption on a created S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Force destroy bucket (When 'false' a non-empty bucket will NOT be destroyed.) | `bool` | `true` | no |
| <a name="input_bucket_logs_enabled"></a> [bucket\_logs\_enabled](#input\_bucket\_logs\_enabled) | Set this to `true` to enable access logging on a created S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Optional value to specify name for a newly created S3 bucket. Not required when `use_existing_cloudtrail` is true. | `string` | `""` | no |
| <a name="input_bucket_sse_algorithm"></a> [bucket\_sse\_algorithm](#input\_bucket\_sse\_algorithm) | The encryption algorithm to use for S3 bucket server-side encryption | `string` | `"aws:kms"` | no |
| <a name="input_bucket_sse_key_arn"></a> [bucket\_sse\_key\_arn](#input\_bucket\_sse\_key\_arn) | The ARN of the KMS encryption key to be used for S3 (Required when `bucket_sse_algorithm` is `aws:kms` and using an existing aws\_kms\_key) | `string` | `""` | no |
| <a name="input_bucket_versioning_enabled"></a> [bucket\_versioning\_enabled](#input\_bucket\_versioning\_enabled) | Set this to `true` to enable access versioning on a created S3 bucket | `bool` | `true` | no |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | The name of the CloudTrail.  Required when setting use\_existing\_cloudtrail to true | `string` | `"lacework-cloudtrail"` | no |
| <a name="input_consolidated_trail"></a> [consolidated\_trail](#input\_consolidated\_trail) | Set this to true to configure a consolidated cloudtrail | `bool` | `false` | no |
| <a name="input_create_lacework_integration"></a> [create\_lacework\_integration](#input\_create\_lacework\_integration) | Set this to `false` if you don't want the module to automatically create a corresponding Lacework integration. | `bool` | `true` | no |
| <a name="input_cross_account_cloudtrail_arn"></a> [cross\_account\_cloudtrail\_arn](#input\_cross\_account\_cloudtrail\_arn) | If using an existing CloudTrail in another account, provide the ARN here | `string` | `null` | no |
| <a name="input_cross_account_policy_name"></a> [cross\_account\_policy\_name](#input\_cross\_account\_policy\_name) | n/a | `string` | `""` | no |
| <a name="input_enable_cloudtrail_s3_management_events"></a> [enable\_cloudtrail\_s3\_management\_events](#input\_enable\_cloudtrail\_s3\_management\_events) | Enable CloudTrail Object-level logging | `bool` | `false` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Specifies whether cloudtrail log file integrity validation is enabled | `bool` | `true` | no |
| <a name="input_external_id_length"></a> [external\_id\_length](#input\_external\_id\_length) | **Deprecated** - Will be removed on our next major release v3.0.0 | `number` | `16` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The IAM role ARN is required when setting use\_existing\_iam\_role to true | `string` | `""` | no |
| <a name="input_iam_role_external_id"></a> [iam\_role\_external\_id](#input\_iam\_role\_external\_id) | The external ID configured inside the IAM role is required when setting use\_existing\_iam\_role to true | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The IAM role name. Required to match with iam\_role\_arn if use\_existing\_iam\_role is set to true | `string` | `""` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account | `bool` | `false` | no |
| <a name="input_kms_key_deletion_days"></a> [kms\_key\_deletion\_days](#input\_kms\_key\_deletion\_days) | The waiting period, specified in number of days | `number` | `30` | no |
| <a name="input_kms_key_multi_region"></a> [kms\_key\_multi\_region](#input\_kms\_key\_multi\_region) | Whether the KMS key is a multi-region or regional key | `bool` | `true` | no |
| <a name="input_kms_key_rotation"></a> [kms\_key\_rotation](#input\_kms\_key\_rotation) | Enable KMS automatic key rotation | `bool` | `false` | no |
| <a name="input_lacework_aws_account_id"></a> [lacework\_aws\_account\_id](#input\_lacework\_aws\_account\_id) | The Lacework AWS account that the IAM role will grant access | `string` | `"434813966438"` | no |
| <a name="input_lacework_integration_name"></a> [lacework\_integration\_name](#input\_lacework\_integration\_name) | The name of the integration in Lacework. | `string` | `"TF cloudtrail"` | no |
| <a name="input_log_bucket_name"></a> [log\_bucket\_name](#input\_log\_bucket\_name) | Name of the S3 bucket for access logs. Is required when setting `use_existing_access_log_bucket` to true | `string` | `""` | no |
| <a name="input_org_account_mappings"></a> [org\_account\_mappings](#input\_org\_account\_mappings) | Mapping of AWS accounts to Lacework accounts within a Lacework organization | <pre>list(object({<br>    default_lacework_account = string<br>    mapping = list(object({<br>      lacework_account = string<br>      aws_accounts     = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_permission_boundary_arn"></a> [permission\_boundary\_arn](#input\_permission\_boundary\_arn) | Optional - ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix that will be use at the beginning of every generated resource | `string` | `"lacework-ct"` | no |
| <a name="input_s3_notification_log_prefix"></a> [s3\_notification\_log\_prefix](#input\_s3\_notification\_log\_prefix) | The object prefix for which to create S3 notifications | `string` | `"AWSLogs/"` | no |
| <a name="input_s3_notification_type"></a> [s3\_notification\_type](#input\_s3\_notification\_type) | The destination type that should be used for S3 notifications: `SNS` or `SQS`. Defaults to `SQS` | `string` | `"SQS"` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | The SNS topic ARN | `string` | `""` | no |
| <a name="input_sns_topic_encryption_enabled"></a> [sns\_topic\_encryption\_enabled](#input\_sns\_topic\_encryption\_enabled) | Set this to `false` to disable encryption on a sns topic. Defaults to true | `bool` | `true` | no |
| <a name="input_sns_topic_encryption_key_arn"></a> [sns\_topic\_encryption\_key\_arn](#input\_sns\_topic\_encryption\_key\_arn) | The ARN of an existing KMS encryption key to be used for SNS | `string` | `""` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The SNS topic name | `string` | `""` | no |
| <a name="input_sqs_encryption_enabled"></a> [sqs\_encryption\_enabled](#input\_sqs\_encryption\_enabled) | Set this to `true` to enable server-side encryption on SQS. | `bool` | `true` | no |
| <a name="input_sqs_encryption_key_arn"></a> [sqs\_encryption\_key\_arn](#input\_sqs\_encryption\_key\_arn) | The ARN of the KMS encryption key to be used for SQS (Required when `sqs_encryption_enabled` is `true`) | `string` | `""` | no |
| <a name="input_sqs_queue_name"></a> [sqs\_queue\_name](#input\_sqs\_queue\_name) | The SQS queue name | `string` | `""` | no |
| <a name="input_sqs_queues"></a> [sqs\_queues](#input\_sqs\_queues) | List of SQS queues to configure in the Lacework cross-account policy | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map/dictionary of Tags to be assigned to created resources | `map(string)` | `{}` | no |
| <a name="input_use_existing_access_log_bucket"></a> [use\_existing\_access\_log\_bucket](#input\_use\_existing\_access\_log\_bucket) | Set this to `true` to use an existing bucket for access logging. Default behavior creates a new access log bucket if logging is enabled | `bool` | `false` | no |
| <a name="input_use_existing_cloudtrail"></a> [use\_existing\_cloudtrail](#input\_use\_existing\_cloudtrail) | Set this to true to use an existing cloudtrail. Default behavior enables new cloudtrail | `bool` | `false` | no |
| <a name="input_use_existing_iam_role"></a> [use\_existing\_iam\_role](#input\_use\_existing\_iam\_role) | Set this to true to use an existing IAM role | `bool` | `false` | no |
| <a name="input_use_existing_iam_role_policy"></a> [use\_existing\_iam\_role\_policy](#input\_use\_existing\_iam\_role\_policy) | Set this to `true` to use an existing policy on the IAM role, rather than attaching a new one | `bool` | `false` | no |
| <a name="input_use_existing_kms_key"></a> [use\_existing\_kms\_key](#input\_use\_existing\_kms\_key) | Set this to true to use an existing KMS key. | `bool` | `false` | no |
| <a name="input_use_existing_sns_topic"></a> [use\_existing\_sns\_topic](#input\_use\_existing\_sns\_topic) | Set this to true to use an existing SNS topic. Default behavior creates a new SNS topic | `bool` | `false` | no |
| <a name="input_use_s3_bucket_notification"></a> [use\_s3\_bucket\_notification](#input\_use\_s3\_bucket\_notification) | Set this to `true` to use S3 bucket notifications instead of CloudTrail. When set to `false` CloudTrail will be used. Defaults to `false` | `bool` | `false` | no |
| <a name="input_wait_time"></a> [wait\_time](#input\_wait\_time) | Amount of time to wait before the next resource is provisioned. | `string` | `"10s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | S3 Bucket ARN |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | S3 Bucket name |
| <a name="output_bucket_sse_key_arn"></a> [bucket\_sse\_key\_arn](#output\_bucket\_sse\_key\_arn) | The ARN of the KMS encryption key used for S3 |
| <a name="output_external_id"></a> [external\_id](#output\_external\_id) | The External ID configured into the IAM role |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The IAM Role ARN |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The IAM Role name |
| <a name="output_lacework_integration_guid"></a> [lacework\_integration\_guid](#output\_lacework\_integration\_guid) | Lacework CloudTrail Integration GUID |
| <a name="output_sns_arn"></a> [sns\_arn](#output\_sns\_arn) | SNS Topic ARN |
| <a name="output_sns_name"></a> [sns\_name](#output\_sns\_name) | SNS Topic name |
| <a name="output_sqs_arn"></a> [sqs\_arn](#output\_sqs\_arn) | SQS Queue ARN |
| <a name="output_sqs_name"></a> [sqs\_name](#output\_sqs\_name) | SQS Queue name |
| <a name="output_sqs_url"></a> [sqs\_url](#output\_sqs\_url) | SQS Queue URL |
<!-- END_TF_DOCS -->
