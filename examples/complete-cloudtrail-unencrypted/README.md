# Deploy New CloudTrail without encryption at rest and Integrate with Lacework

This example creates a new CloudTrail in an AWS account with all of the required resources, as well as creating an IAM Role with a cross-account policy to provide Lacework read-only access to monitor the trail.

**This example purposefully disables encyption at rest, and is not recommended for production environments**

## Inputs

| Name                           | Description                                                                | Type   |
| ------------------------------ | -------------------------------------------------------------------------- | ------ |
| `bucket_encryption_enabled`    | Set this to `true` to use an existing CloudTrail.                          | `bool` |
| `sns_topic_encryption_enabled` | Set this to `false` to disable encryption on a sns topic. Defaults to true | `bool` |
| `sqs_encryption_enabled`       | Set this to `true` to enable server-side encryption on SQS.                | `bool` |

## Sample Code

```hcl
provider "aws" {
  region = "us-west-2"
}

provider "lacework" {}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"

  bucket_encryption_enabled    = false
  sns_topic_encryption_enabled = false
  sqs_encryption_enabled       = false
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
