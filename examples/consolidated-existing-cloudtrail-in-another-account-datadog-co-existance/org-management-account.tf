# in org management account - ID: 100000000000

resource "aws_cloudtrail" "org-trail" {
  name                       = "org-trail"
  s3_bucket_name             = "org-ct-bucket"
  kms_key_id                 = "arn:aws:kms:us-west-2:200000000000:key/6e2010aa-27e4-49c6-8887-956abc1caeb9"
  is_multi_region_trail      = true
  is_organization_trail      = true
  enable_log_file_validation = true

  # Hook the lw cloudtrail sns topic
  sns_topic_name = "arn:aws:sns:us-west-2:200000000000:lw-cloudtrail"
}
