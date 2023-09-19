# Consolidated Existing CloudTrail in Another Account + Co-Existing with Datadog

This example handles a bit of a specific case.

1. You're following the AWS best practice to consolidate all CloudTrail logs into a single "security" account.
* The CloudTrail config itself exists on the org's management account
* The Bucket / KMS key exist on the security account

2. You're setting up LW when either transitioning from Datadog cloudtrail integration, or you're using both LW and Datadog.
* The coveat here is that DD's integration expects to attach a lambda hook to the CloudTrail bucket, only one such hook can be defined on the bucket, and the DD interation can be a bit aggressive about re-claiming this hook.
* This necessitates that the LW integration is done via the SNS topic the LW module sets up instead.

# Important bits of code

## Org Management Account

```hcl
resource "aws_cloudtrail" "org-trail" {
  ...

  # Hook the lw cloudtrail sns topic
  sns_topic_name = "arn:aws:sns:us-west-2:200000000000:lw-cloudtrail"
}
```

## Security Account

```hcl
module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.8"

  consolidated_trail = true

  # Use an existing CloudTrail
  use_existing_cloudtrail   = true
  
  # this is arn to the existung bucket in the security account
  bucket_arn                = "arn:aws:s3:::org-ct-bucket"

  # this is the arn to the trail in the org management account  
  cross_account_cloudtrail_arn = "arn:aws:cloudtrail:us-west-2:100000000000:trail/org-trail" 

  bucket_encryption_enabled = true
  bucket_sse_algorithm      = "aws:kms"
  
  # this is the arn to the kms key in the security account
  bucket_sse_key_arn        = "arn:aws:kms:us-west-2:200000000000:key/6e2010aa-27e4-49c6-8887-956abc1caeb9" 

  # Create new SNS Topic and SQS Queue
  # the SNS topic is referenced in the org management account
  sns_topic_name = "lw-cloudtrail"
  sqs_queue_name = "lw-cloudtrail"

  # Name the integration inside LW UI
  lacework_integration_name = "AWS Consolidated CloudTrail"
}
```
