terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
      version = "~> 0.2.7"
    }
  }
}

provider "aws" {}

provider "lacework" {}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 0.1.3"

  enable_log_file_validation = true
  bucket_force_destroy       = true
  bucket_enable_encryption   = true
  bucket_enable_logs         = true
  bucket_enable_versioning   = true
  
}
