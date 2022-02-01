provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source = "../../"

  kms_key_deletion_days = 30
  bucket_force_destroy  = true

}
