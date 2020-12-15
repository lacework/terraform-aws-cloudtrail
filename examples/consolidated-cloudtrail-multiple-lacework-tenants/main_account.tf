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
  source = "../../"
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
