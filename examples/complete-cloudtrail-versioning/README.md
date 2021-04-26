# Simple CloudTrail Integration w/ Versioning & MFA Delete Protection

This example creates a new CloudTrail with versioning and MFA deletion enabled.

## Inputs

| Name                       | Description                                                                 | Type   |
| -------------------------- | --------------------------------------------------------------------------- | ------ |
| `bucket_enable_mfa_delete` | Set this to `true` to require MFA for object deletion (Requires versioning) | `bool` |
| `bucket_enable_versioning` | Set this to `true` to enable access versioning on a created S3 bucket       | `bool` |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 0.1"

  bucket_enable_mfa_delete = true
  bucket_enable_versioning = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
