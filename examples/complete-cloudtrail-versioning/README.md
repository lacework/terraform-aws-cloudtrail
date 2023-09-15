# Simple CloudTrail Integration w/ Versioning & MFA Delete Protection

This example creates a new CloudTrail with versioning and MFA deletion enabled.

## Inputs

| Name                       | Description                                                                 | Type   |
| -------------------------- | --------------------------------------------------------------------------- | ------ |
| `bucket_enable_mfa_delete` | Set this to `true` to require MFA for object deletion (Requires versioning) | `bool` |
| `bucket_versioning_enabled` | Set this to `true` to enable access versioning on a created S3 bucket       | `bool` |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.0"

  bucket_enable_mfa_delete  = true
  bucket_versioning_enabled = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
