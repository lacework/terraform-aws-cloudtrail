provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"

  # Use S3 Bucket Notifications
  use_s3_bucket_notification = true
}
