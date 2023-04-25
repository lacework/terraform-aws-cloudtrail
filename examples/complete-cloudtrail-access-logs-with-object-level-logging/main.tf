provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  enable_cloudtrail_s3_management_events = true
}
