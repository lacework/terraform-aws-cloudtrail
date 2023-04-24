provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source = "../../"

  bucket_force_destroy = true
}
