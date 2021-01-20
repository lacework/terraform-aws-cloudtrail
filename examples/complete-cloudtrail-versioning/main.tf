provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  bucket_enable_mfa_delete = true
  bucket_enable_versioning = true
}
