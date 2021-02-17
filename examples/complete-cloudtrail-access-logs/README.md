# Simple CloudTrail Integration w/ Access Logs
This example creates a new CloudTrail and the required resources to support it, while also creating an S3 bucket for access logging on the CloudTrail data bucket itself. Once deployed the new CloudTrail will be integrated into Lacework.

| Name | Description | Type |
|------|-------------|------|
| `bucket_enable_logs` | Set this to `true` to enable access logging on a created S3 bucket | `bool` |

```
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
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
