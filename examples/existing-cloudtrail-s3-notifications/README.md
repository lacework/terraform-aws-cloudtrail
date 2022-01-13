# Integrate Existing CloudTrail with Lacework using S3 Bucket Notifications

This example integrates an existing CloudTrail with Lacework and uses S3 Bucket Notifications for updates

## Inputs

| Name                        | Description                                                                      | Type     |
| --------------------------- | -------------------------------------------------------------------------------- | -------- |
| `use_existing_cloudtrail`   | Set this to `true` to use an existing CloudTrail.                                | `bool`   |
| `bucket_arn`                | The S3 bucket ARN configured in the existing CloudTrail.                         | `string` |
| `use_s3_notification_relay` | Set this to `true` to translate S3 bucket notifications for Lacework consumption | `bool`   |

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
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"

  # Use S3 notifications, rather than CloudTrail notifications
  use_s3_notification_relay = true
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
