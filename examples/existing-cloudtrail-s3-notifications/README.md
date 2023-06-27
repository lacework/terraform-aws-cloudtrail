# Integrate Existing CloudTrail using S3 Bucket notifications

This example integrates an existing CloudTrail with Lacework and uses S3 Bucket notifications, rather than CloudTrail SNS notifications.

## Inputs

| Name                         | Description                                                                | Type     |
| ---------------------------- | -------------------------------------------------------------------------- | -------- |
| `use_existing_cloudtrail`    | Set this to `true` to use an existing CloudTrail.                          | `bool`   |
| `bucket_arn`                 | The S3 bucket ARN configured in the existing CloudTrail.                   | `string` |
| `use_s3_bucket_notification` | Set this to `true` to use S3 bucket notifications, rather than CloudTrail. | `bool`   |

## Sample Code

```hcl
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"

  # Use S3 Bucket Notifications
  use_s3_bucket_notification = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
