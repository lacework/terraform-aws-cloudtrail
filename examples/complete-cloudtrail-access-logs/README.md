# Simple CloudTrail Integration w/ Access Logs

In this example, we are creating a new CloudTrail and the necessary resources to support it, while also creating an S3 bucket for access logging on the CloudTrail data bucket itself.

| Name | Description | Type |
|------|-------------|------|
| `bucket_enable_logs` | Set this to `true` to enable access logging on a created S3 bucket | `bool` |
