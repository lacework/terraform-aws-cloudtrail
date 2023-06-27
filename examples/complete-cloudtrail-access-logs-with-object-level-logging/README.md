# Enable Cloudtrail S3 Management Events

This example adds a dynamic event selector in order to enable Object-level logging in CloudTrail.

## Inputs

| Name                                     | Description                                                        | Type   |
| ---------------------------------------- | ------------------------------------------------------------------ | ------ |
| `enable_cloudtrail_s3_management_events` | Set this to `true` to enable CloudTrail Object-level logging.      | `bool` |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"

  enable_cloudtrail_s3_management_events = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
