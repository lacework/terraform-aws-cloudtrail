provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

resource "aws_kms_key" "lacework_kms_key" {
  description  = "A KMS key used to encrypt CloudTrail logs which are monitored by Lacework"
}

module "aws_cloudtrail" {
  source = "../../"

  bucket_force_destroy         = true
  use_existing_kms_key         = true
  bucket_sse_key_arn           = aws_kms_key.lacework_kms_key.arn
  sns_topic_encryption_key_arn = aws_kms_key.lacework_kms_key.arn
  sqs_encryption_key_arn       = aws_kms_key.lacework_kms_key.arn
}
