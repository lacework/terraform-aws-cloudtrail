output "bucket_name" {
  value       = local.bucket_name
  description = "S3 Bucket name"
}

output "bucket_arn" {
  value       = local.bucket_arn
  description = "S3 Bucket ARN"
}

output "sqs_name" {
  value       = local.sqs_queue_name
  description = "SQS Queue name"
}

output "sqs_arn" {
  value       = aws_sqs_queue.lacework_cloudtrail_sqs_queue.arn
  description = "SQS Queue ARN"
}

output "sqs_url" {
  value       = aws_sqs_queue.lacework_cloudtrail_sqs_queue.url
  description = "SQS Queue URL"
}

output "sns_arn" {
  value       = local.sns_topic_arn
  description = "SNS Topic ARN"
}

output "sns_name" {
  value       = local.sns_topic_name
  description = "SNS Topic name"
}

output "external_id" {
  value       = local.iam_role_external_id
  description = "The External ID configured into the IAM role"
}

output "iam_role_name" {
  value       = local.iam_role_name
  description = "The IAM Role name"
}

output "iam_role_arn" {
  value       = local.iam_role_arn
  description = "The IAM Role ARN"
}

output "lacework_integration_guid" {
  value       = local.lacework_integration_guid
  description = "Lacework CloudTrail Integration GUID"
}

output "bucket_sse_key_arn" {
  value       = local.bucket_sse_key_arn
  description = "The ARN of the KMS encryption key used for S3"
}
