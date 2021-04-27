# Deploy New CloudTrail and Integrate with Lacework

This example creates a new CloudTrail in an AWS account with all of the required resources, as well as creating an IAM Role with a cross-account policy to provide Lacework read-only access to monitor the trail.

## Inputs

| Name                         | Description                                                           | Type   |
| ---------------------------- | --------------------------------------------------------------------- | ------ |
| `bucket_enable_encryption`   | Set this to `true` to enable encryption on a created S3 bucket        | `bool` |
| `bucket_enable_logs`         | Set this to `true` to enable access logging on a created S3 bucket    | `bool` |
| `bucket_enable_versioning`   | Set this to `true` to enable access versioning on a created S3 bucket | `bool` |
| `bucket_force_destroy`       | Force destroy bucket (Required when bucket not empty)                 | `bool` |
| `enable_log_file_validation` | Set this to `true` to use an existing CloudTrail.                     | `bool` |

## Sample Code

```hcl
provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 0.1"

  bucket_enable_encryption   = true
  bucket_enable_logs         = true
  bucket_enable_versioning   = true
  bucket_force_destroy       = true
  enable_log_file_validation = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform).
