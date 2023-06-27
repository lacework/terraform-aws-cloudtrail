# Consolidated CloudTrail - Multiple Lacework Accounts

This example configures a consolidated cloudtrail on three AWS accounts, one main
account that owns the consolidated CloudTrail and two sub-accounts where we configure
sub-tails to point to the main trail from the main account.

The only difference from the `consolidated-cloudtrail` example is that here we configure
the Lacework integration at the Organization level and map the AWS accounts to Lacework
sub-accounts via the `org_account_mappings` field.

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
  org_account_mappings = [{
    default_lacework_account = "main-account"
    mapping = [
      {
        lacework_account = "sub-account-1"
        aws_accounts     = ["123456789011"]
      },
      {
        lacework_account = "sub-account-2"
        aws_accounts     = ["123456789012"]
      }
    ]
  }]
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

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://docs.lacework.net/onboarding/aws-guided-configuration).
