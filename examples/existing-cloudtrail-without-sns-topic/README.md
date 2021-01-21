# Integrate Existing CloudTrail Without SNS Notifications

In this example we allow users pass an existing CloudTrail that does
not have SNS notifications enabled. The module will automatically create
an SNS topic that must be configured into the existing CloudTrail, either
manually or via your own Terraform code.

The fields required for this example are:

| Name | Description | Type |
|------|-------------|------|
| `use_existing_cloudtrail` | Set this to `true` to use an existing CloudTrail. | `bool` |
| `bucket_name` | The S3 bucket name configured in the existing CloudTrail. | `string` |
| `bucket_arn` | The S3 bucket ARN configured in the existing CloudTrail. | `string` |

**IMPORTANT:** If the existing CloudTrail does have SNS notification enabled, look at
the example named [existing-cloudtrail](https://registry.terraform.io/modules/lacework/cloudtrail/aws/latest/examples/existing-cloudtrail)

After running `terraform apply`, it is necessary to configure the SNS topic into
the existing CloudTrail

**IMPORTANT: This example does not modify your CloudTrail, therefore, you must enable
SNS delivery notifications manually and point to the generated SNS topic.**

## Enable SNS delivery notifications manually
![](../../img/cloudtrail_enable_sns_delivery_notifications.gif)

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
  version = "~> 0.1.3"

  use_existing_cloudtrail = true
  bucket_name             = "bucket name from existing cloudtrail"
  bucket_arn              = "bucket ARN from existing cloudtrail"
}
```
