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
}
