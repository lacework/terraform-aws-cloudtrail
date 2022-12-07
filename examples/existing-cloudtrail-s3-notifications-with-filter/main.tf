provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

locals {
  accountids_with_lacework_enabled = [
    "111111111111",
  ]
}

module "aws_cloudtrail" {
  source = "../../"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"

  # Use S3 Bucket Notifications
  use_s3_bucket_notification = true
  s3_notification_type       = "SNS"
  sns_topic_filter_policy = jsonencode({
    # SNS filtering https://docs.aws.amazon.com/sns/latest/dg/sns-message-filtering.html
    # SNS event example https://docs.aws.amazon.com/awscloudtrail/latest/userguide/configure-sns-notifications-for-cloudtrail.html
    # S3 cloudtrail path format https://docs.aws.amazon.com/AmazonS3/latest/userguide/cloudtrail-request-identification.html
    s3ObjectKey = {
      Type = "String.Array"
      Value = [
        for accountid in local.accountids_with_lacework_enabled :
        {
          prefix = "AWSLogs/${accountid}/"
        }
      ]
    }
  })
  sns_topic_filter_policy_scope = "MessageBody"
}
