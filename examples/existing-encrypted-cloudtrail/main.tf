provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  # Use an existing CloudTrail
  use_existing_cloudtrail  = true
  bucket_arn               = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_enable_encryption = true
  bucket_name              = "lacework-ct-bucket-8805c0bf"
  bucket_sse_algorithm     = "aws:kms"
  bucket_sse_key_arn       = "arn:aws:kms:us-east-1:1234567890:key/6e2010aa-27e4-49c6-8887-956abc1caeb9"
  sns_topic_name           = "lacework-ct-sns-8805c0bf"
}
