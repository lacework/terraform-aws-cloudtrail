# Integrate Existing CloudTrail Without SNS Notifications

This example integrates an existing CloudTrail with Lacework that does not have SNS notifications enabled. The module will automatically create an SNS topic that must be configured into the existing CloudTrail, either manually or via your own Terraform code.

**IMPORTANT:** If the existing CloudTrail does have SNS notification enabled, look at
the example named [existing-cloudtrail](https://registry.terraform.io/modules/lacework/cloudtrail/aws/latest/examples/existing-cloudtrail)

**IMPORTANT:** The new SNS topic must be created in the same region as the existing CloudTrail.

**IMPORTANT:** The existing `cloudtrail_name` is required for the SNS Topic policy.

## Inputs

| Name                      | Description                                               | Type     |
| ------------------------- | --------------------------------------------------------- | -------- |
| `use_existing_cloudtrail` | Set this to `true` to use an existing CloudTrail.         | `bool`   |
| `bucket_arn`              | The S3 bucket ARN configured in the existing CloudTrail.  | `string` |
| `cloudtrail_name`         | The name of the existing CloudTrail                       | `string` |

**IMPORTANT:** This example does not modify your CloudTrail, therefore, you must enable
SNS delivery notifications manually and point to the generated SNS topic.

## Enable SNS delivery notifications manually

![](https://techally-artifacts.s3-us-west-2.amazonaws.com/terraform-module-docs/cloudtrail_enable_sns_delivery_notifications.gif)

## Enable SNS delivery notifications via Terraform

If you already have Terraform code deployed that configures the existing CloudTrail
provided, you can plug the output `sns_arn` from this module as the following example:

```hcl
resource "aws_cloudtrail" "your_existing_trail" {

  // ... lots of existing settings ...

  // enable SNS delivery notifications
  sns_topic_name = module.lacework_cloudtrail.sns_arn
}

module "lacework_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"

  use_existing_cloudtrail = true
  bucket_arn              = "bucket ARN from existing cloudtrail"
  cloudtrail_name         = "lacework-cloudtrail"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
