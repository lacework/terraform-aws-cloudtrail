provider "aws" {
  profile = "sub-account-1"
  alias   = "sub-account-1"
  region  = "us-west-2"
}

resource "aws_cloudtrail" "sub_account_1" {
  provider              = aws.sub-account-1
  name                  = "sub-trail"
  is_multi_region_trail = true
  s3_bucket_name        = module.main_cloudtrail.bucket_name
  sns_topic_name        = module.main_cloudtrail.sns_arn
}

