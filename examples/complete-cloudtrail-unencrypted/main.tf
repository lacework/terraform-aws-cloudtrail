provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source = "../../"

  bucket_encryption_enabled    = false
  sns_topic_encryption_enabled = false
  sqs_encryption_enabled       = false
}
