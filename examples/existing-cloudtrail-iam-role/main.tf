provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-7bb591f4"
  bucket_name             = "lacework-ct-bucket-7bb591f4"

  # Use an existing SNS Topic
  use_existing_sns_topic = true
  sns_topic_arn          = "arn:aws:sns:us-west-2:123456789012:lacework-ct-sns-7bb591f4"

  # Use an existing IAM role
  use_existing_iam_role = true
  iam_role_arn          = "arn:aws:iam::123456789012:role/lw-existing-role"
  iam_role_name         = "lw-existing-role"
  iam_role_external_id  = "1GrDkEZV5VJ@=nLm"
}
