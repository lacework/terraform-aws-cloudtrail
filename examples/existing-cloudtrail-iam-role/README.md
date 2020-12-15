# Integrate Existing CloudTrail and IAM Role

In this example we let users pass an existing CloudTrail and IAM Role,
the fields required for this example are:

| Name | Description | Type |
|------|-------------|------|
| `use_existing_cloudtrail` | Set this to `true` to use an existing CloudTrail. | `bool` |
| `bucket_name` | The S3 bucket name configured in the existing CloudTrail. | `string` |
| `bucket_arn` | The S3 bucket ARN configured in the existing CloudTrail. | `string` |
| `sns_topic_name` | The SNS topic name configured in the existing CloudTrail. | `string` |
| `use_existing_iam_role` | Set this to `true` to use an existing IAM Role. | `bool` |
| `iam_role_name` | The existing IAM role name. | `string` |
| `iam_role_arn` | The existing IAM role ARN. | `string` |
