# Integrate Existing CloudTrail with Lacework Using Existing SNS Topic

This example integrates an existing CloudTrail with Lacework and uses an existing SNS topic already configured for the trail.

The fields required for this example are:

| Name | Description | Type |
|------|-------------|------|
| `use_existing_cloudtrail` | Set this to `true` to use an existing CloudTrail. | `bool` |
| `bucket_name` | The S3 bucket name configured in the existing CloudTrail. | `string` |
| `bucket_arn` | The S3 bucket ARN configured in the existing CloudTrail. | `string` |
| `sns_topic_name` | The SNS topic name configured in the existing CloudTrail. | `string` |

**IMPORTANT: This example assumes that your CloudTrail is already sending delivery notifications
to the provided SNS topic. If the existing CloudTrail does NOT have SNS notification enabled,
look at the example named [existing-cloudtrail-without-sns-topic](https://registry.terraform.io/modules/lacework/cloudtrail/aws/latest/examples/existing-cloudtrail-without-sns-topic)**

```
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source = "../../"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_name             = "lacework-ct-bucket-8805c0bf"
  sns_topic_name          = "lacework-ct-sns-8805c0bf"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)