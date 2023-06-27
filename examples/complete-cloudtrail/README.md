# Deploy New CloudTrail and Integrate with Lacework

This example creates a new CloudTrail in an AWS account with all of the required resources,
as well as creating an IAM Role with a cross-account policy to provide Lacework read-only
access to monitor the trail.

## Sample Code

```hcl
provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.0"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
