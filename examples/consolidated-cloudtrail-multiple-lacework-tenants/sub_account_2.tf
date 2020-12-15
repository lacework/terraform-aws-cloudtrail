provider "aws" {
  profile = "sub-account-2"
  alias   = "sub-account-2"
  region  = "us-west-2"
}

resource "aws_cloudtrail" "sub_account_2" {
  provider              = aws.sub-account-2
  name                  = "sub-trail"
  is_multi_region_trail = true
  s3_bucket_name        = module.main_cloudtrail.bucket_name
  sns_topic_name        = module.main_cloudtrail.sns_arn
}
