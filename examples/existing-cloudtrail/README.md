# Integrate Existing CloudTrail With SNS Notifications

In this example we allow users pass an existing CloudTrail with the
caveat that the provided CloudTrail must have SNS notifications enabled.

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
