# Simple CloudTrail Integration

This example will provision the following resources in the designated AWS account:

* IAM Cross Account Role - A cross account role is required to give access to Lacework access for analysis of CloudTrail events. The cross account role will be given the following policies:
  * SecurityAudit - AWS Managed Policy to provide read-only access to cloud resource configurations.
  * Lacework Custom IAM Policy - A custom policy that provides Lacework read-only access to injest CloudTrail logs.
* CloudTrail - Lacework can create a new trail or use an existing CloudTrail.
* S3 Bucket - An S3 bucket is required for all CloudTrail integrations. Lacework can use an existing bucket or create a new bucket in the designated account.
* SNS Topic - An SNS topic is required for all CloudTrail integrations. Terraform can use an existing SNS topic or create one if an SNS topic has not be added to an existing CloudTrail.
* SQS Queue - An SQS queue is required for all CloudTrail integrations and monitored by Lacework.
