# v0.1.6

## Documentation Updates
* docs: Update examples for all scenarios (#24) (Scott Ford)([8f2c9d4](https://github.com/lacework/terraform-aws-cloudtrail/commit/8f2c9d4f70fe4b18481c4254228a18929056e418))
---
# v0.1.5

## Refactor
* refactor: improved logic for `mfa_delete` variable (#19) (Alan Nix)([17f0a5a](https://github.com/lacework/terraform-aws-cloudtrail/commit/17f0a5a66cf70bec4ba17582778f492f0431df4b))
## Documentation Updates
* docs: Fix link to sns gif (#21) (Scott Ford)([d5d9881](https://github.com/lacework/terraform-aws-cloudtrail/commit/d5d988184015fee3b5740869dafeed94bbf7624c))
* docs: update mfa_delete default (#20) (Salim Afiune)([d30789b](https://github.com/lacework/terraform-aws-cloudtrail/commit/d30789b4497b849d52e93dcf5cb4106e59b1383f))
---
# v0.1.4

## Features
* feat: support for 'mfa_delete' variable (#14) (Alan Nix)([f0f48de](https://github.com/lacework/terraform-aws-cloudtrail/commit/f0f48dedb4332c0c86cd8447c0889224b6353a86))
* feat: support for enable_log_file_validation (Salim Afiune Maya)([8126244](https://github.com/lacework/terraform-aws-cloudtrail/commit/8126244323aa1e89a5c5d3c1d5f40e36d05b8a8c))
## Documentation Updates
* docs: add SNS topic examples (#17) (Salim Afiune)([aa29872](https://github.com/lacework/terraform-aws-cloudtrail/commit/aa298725c741338e12386fd9a63ded0e1f1e731c))
* docs: additional examples (#16) (Alan Nix)([ee03202](https://github.com/lacework/terraform-aws-cloudtrail/commit/ee03202bb0a8045f056a0c8f9f96763d8f57ad03))
## Other Changes
* ci: send slack notifications to team alias ⭐ (Salim Afiune Maya)([f130589](https://github.com/lacework/terraform-aws-cloudtrail/commit/f1305893f4303495200c6b7a83f0eca27ccb75f0))
---
# v0.1.3

## Features
* feat: support org_account_mappings (Salim Afiune Maya)([20106c8](https://github.com/lacework/terraform-aws-cloudtrail/commit/20106c8270cf58ea0bc56082544a8350abd4e43b))
## Documentation Updates
* docs: update variables description (Salim Afiune Maya)([0aef1ab](https://github.com/lacework/terraform-aws-cloudtrail/commit/0aef1abd812b986e9ff774734dc7b1da735f0250))
* docs: update examples/ (Salim Afiune Maya)([027dfbb](https://github.com/lacework/terraform-aws-cloudtrail/commit/027dfbb82b152ec482381e1b20ec082abdc96e29))
---
# v0.1.2

## Features
* feat(tags): Added the ability to tag created resources (#6) (Alan Nix)([b53d1b7](https://github.com/lacework/terraform-aws-cloudtrail/commit/b53d1b7cbe462f4c342a08f7ea5adf0d99978c97))
## Bug Fixes
* fix: readd removed lines in release script (#9) (Darren)([18850b8](https://github.com/lacework/terraform-aws-cloudtrail/commit/18850b8472eb3acef57ed807b4c9008c9f559702))
## Other Changes
* ci: new release.sh release notes generation  (#7) (Darren)([28750d0](https://github.com/lacework/terraform-aws-cloudtrail/commit/28750d051f6cbcdb7c22bccb2293f6ca85acb6a4))
---
# v0.1.1

## Bug Fixes
* fix(aws): gracefully handle trailing slash in bucket_arn (Alan Nix)([311bf79](https://github.com/lacework/terraform-aws-cloudtrail/commit/311bf796f483f9d558af154d471fab88aa4dab61))
* fix(module): patch iam-role module to aws 3.x (Salim Afiune Maya)([b7e8245](https://github.com/lacework/terraform-aws-cloudtrail/commit/b7e8245e3d3b665e7899b2051c320df7f029913f))
## Other Changes
* chore(version): bump to aws 3.x provider (Salim Afiune Maya)([aa62cea](https://github.com/lacework/terraform-aws-cloudtrail/commit/aa62cea899dc96cee176be944610416cc79b1f98))
* ci: rename the default branch to main (#1) (Salim Afiune)([927e7ce](https://github.com/lacework/terraform-aws-cloudtrail/commit/927e7cef18f086f540b7b673a53c194d03491a38))
---
# v0.1.0

Initial commit
