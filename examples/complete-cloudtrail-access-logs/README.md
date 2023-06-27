# Simple CloudTrail Integration w/ Access Logs

This example creates a new CloudTrail and the required resources to support it, while also creating an S3 bucket for access logging on the CloudTrail data bucket itself. Once deployed the new CloudTrail will be integrated into Lacework.

## Inputs

| Name                 | Description                                                        | Type   |
| -------------------- | ------------------------------------------------------------------ | ------ |
| `bucket_logs_enabled` | Set this to `true` to enable access logging on a created S3 bucket | `bool` |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"

  bucket_logs_enabled = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
