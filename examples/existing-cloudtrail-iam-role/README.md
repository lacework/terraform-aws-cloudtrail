# Integrate Existing CloudTrail and IAM Role

This example integrates an existing CloudTrail and uses an existing IAM Role to configure the cross-account policy to provide Lacework access to monitor the trail.

## Inputs

| Name                      | Description                                               | Type     |
| ------------------------- | --------------------------------------------------------- | -------- |
| `use_existing_cloudtrail` | Set this to `true` to use an existing CloudTrail.         | `bool`   |
| `bucket_arn`              | The S3 bucket ARN configured in the existing CloudTrail.  | `string` |
| `bucket_name`             | The S3 bucket name configured in the existing CloudTrail. | `string` |
| `use_existing_sns_topic`  | Set this to `true` to use an existing SNS topic           | `bool`   |
| `sns_topic_arn`           | The SNS topic ARN configured in the existing CloudTrail.  | `string` |
| `use_existing_iam_role`   | Set this to `true` to use an existing IAM Role.           | `bool`   |
| `iam_role_arn`            | The existing IAM role ARN.                                | `string` |
| `iam_role_name`           | The existing IAM role name.                               | `string` |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 0.1"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-7bb591f4"
  bucket_name             = "lacework-ct-bucket-7bb591f4"

  # Use an existing SNS Topic
  use_existing_sns_topic = true
  sns_topic_arn          = "arn:aws:sns:us-west-2:123456789012:lacework-ct-sns-7bb591f4"

  # Use an existing IAM role
  use_existing_iam_role = true
  iam_role_arn          = "arn:aws:iam::123456789012:role/lw-existing-role"
  iam_role_name         = "lw-existing-role"
  iam_role_external_id  = "1GrDkEZV5VJ@=nLm"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
