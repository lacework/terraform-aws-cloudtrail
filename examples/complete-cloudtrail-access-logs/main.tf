provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  bucket_enable_logs = true
}
