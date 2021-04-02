# Integrate Existing Encrypted CloudTrail

In this example we let users pass an existing CloudTrail that is encrypted using a KMS key, the fields required for this example are:

| Name                       | Description                                                    | Type     |
| -------------------------- | -------------------------------------------------------------- | -------- |
| `use_existing_cloudtrail`  | Set this to `true` to use an existing CloudTrail.              | `bool`   |
| `bucket_arn`               | The S3 bucket ARN configured in the existing CloudTrail.       | `string` |
| `bucket_enable_encryption` | Set this to `true` to enable encryption on a created S3 bucket | `bool`   |
| `bucket_name`              | The S3 bucket name configured in the existing CloudTrail.      | `string` |
| `bucket_sse_algorithm`     | Name of the server-side encryption algorithm to use            | `string` |
| `bucket_sse_key_arn`       | The ARN of the KMS encryption key to be used                   | `string` |
| `use_existing_sns_topic`   | Set this to `true` to use an existing SNS topic                | `bool`   |
| `sns_topic_arn`            | The SNS topic ARN configured in the existing CloudTrail.       | `string` |
