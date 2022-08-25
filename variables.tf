variable "consolidated_trail" {
  type        = bool
  default     = false
  description = "Set this to true to configure a consolidated cloudtrail"
}

variable "is_organization_trail" {
  type        = bool
  default     = false
  description = "Whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account"
}

variable "org_account_mappings" {
  type = list(object({
    default_lacework_account = string
    mapping = list(object({
      lacework_account = string
      aws_accounts     = list(string)
    }))
  }))
  default     = []
  description = "Mapping of AWS accounts to Lacework accounts within a Lacework organization"
}

variable "use_existing_iam_role" {
  type        = bool
  default     = false
  description = "Set this to true to use an existing IAM role"
}

variable "iam_role_name" {
  type        = string
  default     = ""
  description = "The IAM role name. Required to match with iam_role_arn if use_existing_iam_role is set to true"
}

variable "iam_role_arn" {
  type        = string
  default     = ""
  description = "The IAM role ARN is required when setting use_existing_iam_role to true"
}

variable "iam_role_external_id" {
  type        = string
  default     = ""
  description = "The external ID configured inside the IAM role is required when setting use_existing_iam_role to true"
}

variable "external_id_length" {
  type        = number
  default     = 16
  description = "The length of the external ID to generate. Max length is 1224. Ignored when use_existing_iam_role is set to true"
}

variable "prefix" {
  type        = string
  default     = "lacework-ct"
  description = "The prefix that will be use at the beginning of every generated resource"
}

variable "enable_log_file_validation" {
  type        = bool
  default     = true
  description = "Specifies whether cloudtrail log file integrity validation is enabled"
}

variable "bucket_name" {
  type        = string
  default     = ""
  description = "Optional value to specify name for a newly created S3 bucket. Not required when `use_existing_cloudtrail` is true."
}

variable "bucket_arn" {
  type        = string
  default     = ""
  description = "The S3 bucket ARN is required when setting use_existing_cloudtrail to true"
}

variable "bucket_encryption_enabled" {
  type        = bool
  default     = true
  description = "Set this to `true` to enable encryption on a created S3 bucket"
}

variable "bucket_logs_enabled" {
  type        = bool
  default     = true
  description = "Set this to `true` to enable access logging on a created S3 bucket"
}

variable "bucket_enable_mfa_delete" {
  type        = bool
  default     = false
  description = "Set this to `true` to require MFA for object deletion (Requires versioning)"
}

variable "bucket_versioning_enabled" {
  type        = bool
  default     = true
  description = "Set this to `true` to enable access versioning on a created S3 bucket"
}

variable "bucket_force_destroy" {
  type        = bool
  default     = false
  description = "Force destroy bucket (Required when bucket not empty)"
}

variable "bucket_sse_algorithm" {
  type        = string
  default     = "aws:kms"
  description = "The encryption algorithm to use for S3 bucket server-side encryption"
}

variable "bucket_sse_key_arn" {
  type        = string
  default     = ""
  description = "The ARN of the KMS encryption key to be used for S3 (Required when `bucket_sse_algorithm` is `aws:kms` and using an existing aws_kms_key)"
}

variable "log_bucket_name" {
  type        = string
  default     = ""
  description = "Name of the S3 bucket for access logs. Is required when setting `use_existing_access_log_bucket` to true"
}

variable "access_log_prefix" {
  type        = string
  default     = "log/"
  description = "Optional value to specify a key prefix for access log objects for logging S3 bucket"
}

variable "ignore_org_account_mapping_changes" {
  type        = bool
  default     = false
  description = "Set this to `true` to ignore out-of-band changes to the `org_account_mappings` state."
}

variable "s3_notification_log_prefix" {
  type        = string
  default     = "AWSLogs/"
  description = "The object prefix for which to create S3 notifications"
}

variable "s3_notification_type" {
  type        = string
  default     = "SQS"
  description = "The destination type that should be used for S3 notifications: `SNS` or `SQS`. Defaults to `SQS`"

  validation {
    condition     = contains(["SNS", "SQS"], var.s3_notification_type)
    error_message = "Valid values for variable 's3_notification_type' are: ['SNS', 'SQS']."
  }
}

variable "sns_topic_arn" {
  type        = string
  default     = ""
  description = "The SNS topic ARN"
}

variable "sns_topic_name" {
  type        = string
  default     = ""
  description = "The SNS topic name"
}

variable "sns_topic_encryption_key_arn" {
  type        = string
  default     = ""
  description = "The ARN of an existing KMS encryption key to be used for SNS"
}

variable "sns_topic_encryption_enabled" {
  type        = bool
  default     = true
  description = "Set this to `false` to disable encryption on a sns topic. Defaults to true"
}

variable "sqs_queue_name" {
  type        = string
  default     = ""
  description = "The SQS queue name"
}

variable "sqs_encryption_enabled" {
  type        = bool
  default     = true
  description = "Set this to `true` to enable server-side encryption on SQS."
}

variable "sqs_encryption_key_arn" {
  type        = string
  default     = ""
  description = "The ARN of the KMS encryption key to be used for SQS (Required when `sqs_encryption_enabled` is `true`)"
}

variable "use_s3_bucket_notification" {
  type        = bool
  default     = false
  description = "Set this to `true` to use S3 bucket notifications instead of CloudTrail. When set to `false` CloudTrail will be used. Defaults to `false`"
}

variable "use_existing_cloudtrail" {
  type        = bool
  default     = false
  description = "Set this to true to use an existing cloudtrail. Default behavior enables new cloudtrail"
}

variable "use_existing_access_log_bucket" {
  type        = bool
  default     = false
  description = "Set this to `true` to use an existing bucket for access logging. Default behavior creates a new access log bucket if logging is enabled"
}

variable "use_existing_sns_topic" {
  type        = bool
  default     = false
  description = "Set this to true to use an existing SNS topic. Default behavior creates a new SNS topic"
}

variable "cloudtrail_name" {
  type        = string
  default     = "lacework-cloudtrail"
  description = "The name of the CloudTrail"
}

variable "cross_account_policy_name" {
  type    = string
  default = ""
}

variable "sqs_queues" {
  type        = list(string)
  default     = []
  description = "List of SQS queues to configure in the Lacework cross-account policy"
}

variable "lacework_integration_name" {
  type        = string
  default     = "TF cloudtrail"
  description = "The name of the integration in Lacework."
}

variable "lacework_aws_account_id" {
  type        = string
  default     = "434813966438"
  description = "The Lacework AWS account that the IAM role will grant access"
}

variable "wait_time" {
  type        = string
  default     = "10s"
  description = "Amount of time to wait before the next resource is provisioned."
}

variable "tags" {
  type        = map(string)
  description = "A map/dictionary of Tags to be assigned to created resources"
  default     = {}
}

variable "kms_key_rotation" {
  type        = bool
  default     = false
  description = "Enable KMS automatic key rotation"
}

variable "kms_key_deletion_days" {
  type        = number
  default     = 30
  description = "The waiting period, specified in number of days"
}

variable "kms_key_multi_region" {
  type        = bool
  default     = true
  description = "Whether the KMS key is a multi-region or regional key"
}
