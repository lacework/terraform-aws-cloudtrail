provider "aws" {}

provider "lacework" {}

module "aws_cloudtrail" {
  source = "../../"

  enable_log_file_validation = true
  bucket_force_destroy       = true
  bucket_enable_encryption   = true
  bucket_enable_logs         = true
  bucket_enable_versioning   = true
  
}
