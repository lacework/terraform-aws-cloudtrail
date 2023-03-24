provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-4d857633"
  bucket_name             = "lacework-ct-bucket-4d857633"
  cloudtrail_name         = "lacework-cloudtrail"
}
