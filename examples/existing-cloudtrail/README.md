# Integrate Existing CloudTrail with Lacework Using Existing SNS Topic

This example integrates an existing CloudTrail with Lacework and uses an existing SNS topic already configured for the trail.

The fields required for this example are:

| Name                      | Description                                               | Type     |
| ------------------------- | --------------------------------------------------------- | -------- |
| `use_existing_cloudtrail` | Set this to `true` to use an existing CloudTrail.         | `bool`   |
| `bucket_arn`              | The S3 bucket ARN configured in the existing CloudTrail.  | `string` |
| `bucket_name`             | The S3 bucket name configured in the existing CloudTrail. | `string` |
| `use_existing_sns_topic`  | Set this to `true` to use an existing SNS topic           | `bool`   |
| `sns_topic_arn`           | The SNS topic ARN configured in the existing CloudTrail.  | `string` |

**IMPORTANT: This example assumes that your CloudTrail is already sending delivery notifications
to the provided SNS topic. If the existing CloudTrail does NOT have SNS notification enabled,
look at the example named [existing-cloudtrail-without-sns-topic](https://registry.terraform.io/modules/lacework/cloudtrail/aws/latest/examples/existing-cloudtrail-without-sns-topic)**

```
provider "lacework" {}

provider "aws" {
  region = "us-west-2"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 0.1.5"

  # Use an existing CloudTrail
  use_existing_cloudtrail = true
  bucket_arn              = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_name             = "lacework-ct-bucket-8805c0bf"

  # Use an existing SNS Topic
  use_existing_sns_topic = true
  sns_topic_arn          = "arn:aws:sns:us-west-2:713578388890:lacework-ct-sns-8805c0bf"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
