# Consolidated CloudTrail

This example configures a consolidated cloudtrail on three AWS accounts, one main
account that owns the consolidated CloudTrail and two sub-accounts where we configure
sub-tails to point to the main trail from the main account.

## Sample Code

### main.tf

```hcl
provider "lacework" {
  profile = "main-account"
  alias   = "main-account"
}

provider "aws" {
  profile = "main-account"
  alias   = "main-account"
  region  = "us-west-2"
}

module "main_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 1.0"
  providers = {
    aws      = aws.main-account
    lacework = lacework.main-account
  }

  consolidated_trail = true
}
```

### sub_account_1.tf

```hcl
provider "aws" {
  profile = "sub-account-1"
  alias   = "sub-account-1"
  region  = "us-west-2"
}

resource "aws_cloudtrail" "sub_account_1" {
  provider              = aws.sub-account-1
  name                  = "sub-trail"
  is_multi_region_trail = true
  s3_bucket_name        = module.main_cloudtrail.bucket_name
  sns_topic_name        = module.main_cloudtrail.sns_arn
}
```

### sub_account_2.tf

```hcl
provider "aws" {
  profile = "sub-account-2"
  alias   = "sub-account-2"
  region  = "us-west-2"
}

resource "aws_cloudtrail" "sub_account_2" {
  provider              = aws.sub-account-2
  name                  = "sub-trail"
  is_multi_region_trail = true
  s3_bucket_name        = module.main_cloudtrail.bucket_name
  sns_topic_name        = module.main_cloudtrail.sns_arn
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
