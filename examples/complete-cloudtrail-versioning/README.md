# Simple CloudTrail Integration w/ Versioning & MFA Delete Protection

In this example, we are creating a new CloudTrail with versioning and MFA deletion enabled.

| Name | Description | Type |
|------|-------------|------|
| `bucket_enable_mfa_delete` | Set this to `true` to require MFA for object deletion (Requires versioning) | `bool` |
| `bucket_enable_versioning` | Set this to `true` to enable access versioning on a created S3 bucket | `bool` |
