provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source = "../../"
}
