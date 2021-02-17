terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
      version = "~> 0.2.7"
    }
  }
}

provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  bucket_enable_logs = true
}
