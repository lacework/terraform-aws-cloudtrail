# in a "security" account - ID: 200000000000

provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

# the CT logs live in this account
# Note: in order to make this co-exist with Datadog (useful for the transitional period)
#       datadog has to be allowed to maintain the lambda hook on the bucket, so we can't have
#       LW hook that (it'd be the easiest option)
resource "aws_s3_bucket" "ct_bucket" {
  bucket = "org-ct-bucket"
}

# and so does their KMS Key
# let's assume its ARN is: arn:aws:kms:us-west-2:200000000000:key/6e2010aa-27e4-49c6-8887-956abc1caeb9
resource "aws_kms_key" "ct_key" {
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.8"

  consolidated_trail = true

  # Use an existing CloudTrail
  use_existing_cloudtrail   = true
  bucket_arn                = "arn:aws:s3:::org-ct-bucket"
  cross_account_cloudtrail_arn = "arn:aws:cloudtrail:us-west-2:100000000000:trail/org-trail"

  bucket_encryption_enabled = true
  bucket_sse_algorithm      = "aws:kms"
  bucket_sse_key_arn        = "arn:aws:kms:us-west-2:200000000000:key/6e2010aa-27e4-49c6-8887-956abc1caeb9"

  # Create new SNS Topic and SQS Queue
  sns_topic_name = "lw-cloudtrail"
  sqs_queue_name = "lw-cloudtrail"

  # Name the integration inside LW UI
  lacework_integration_name = "AWS Consolidated CloudTrail"
}
