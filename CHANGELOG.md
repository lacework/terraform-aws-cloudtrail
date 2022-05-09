# v2.1.1

## Bug Fixes
* fix: Use ternary instead of && for boolean logic (#84) (Jeff Gran)([594fbad](https://github.com/lacework/terraform-aws-cloudtrail/commit/594fbad8e6d25c8feef71e1ab6a9d2d1b2b47603))
## Other Changes
* ci: version bump to v2.1.1-dev (Lacework)([d45190f](https://github.com/lacework/terraform-aws-cloudtrail/commit/d45190f5338ae5e1effde3fd0a8d6175bd921b25))
---
# v2.1.0

## Features
* feat: support the creation of organizational trail (#82) (Salim Afiune)([e9b99b1](https://github.com/lacework/terraform-aws-cloudtrail/commit/e9b99b19f18225e6b126f80270e0af852a32b4a7))
## Other Changes
* ci: version bump to v2.0.1-dev (Lacework)([35e3dbb](https://github.com/lacework/terraform-aws-cloudtrail/commit/35e3dbb2911f8187f826d2a4d2bd97c7d7c70088))
---
# v2.0.0

## Refactor
* refactor: s3 bucket resources for v4 aws provider (#77) (Darren)([87d6bcb](https://github.com/lacework/terraform-aws-cloudtrail/commit/87d6bcb407ac24c4069c35df2a13d07c5d717214))
## Other Changes
* ci: version bump to v1.1.1-dev (Lacework)([e3e753e](https://github.com/lacework/terraform-aws-cloudtrail/commit/e3e753e2b4389904513d0ef99a47f619bb01cfac))
---
# v1.1.0

## Features
* feat: add kms_key_rotation variable to control KMS auto rotation (#69) (Philippe M. Chiasson)([1474a02](https://github.com/lacework/terraform-aws-cloudtrail/commit/1474a0215fec95a8f45ed5542fcb94122d43bb91))
## Bug Fixes
* fix: aws required_provider version constraint (#74) (Salim Afiune)([ea075eb](https://github.com/lacework/terraform-aws-cloudtrail/commit/ea075eb3a0c1d2da27422cb0b9ab6301e6b4fc3a))
## Other Changes
* ci: version bump to v1.0.3-dev (Lacework)([563e9a8](https://github.com/lacework/terraform-aws-cloudtrail/commit/563e9a8705c21870c39f20339ce45c793f39158c))
---
# v1.0.2

## Bug Fixes
* fix: bucket_encryption_enabled checks SSE Key ARN length (#71) (Salim Afiune)([40578eb](https://github.com/lacework/terraform-aws-cloudtrail/commit/40578eb2f0ff0584d476ccf100c97d84b0564a0d))
## Documentation Updates
* docs: update README to match bucket_sse_algorithm default (#68) (Albert Dixon)([392c3a8](https://github.com/lacework/terraform-aws-cloudtrail/commit/392c3a814ecaf7cd2e7528fd7ac18d49f67f88bd))
## Other Changes
* chore: update PR template (#70) (Darren)([1ecf01b](https://github.com/lacework/terraform-aws-cloudtrail/commit/1ecf01bb7ce7ee6b78c0cc15389e8523956dd539))
* ci: version bump to v1.0.2-dev (Lacework)([dc26bd1](https://github.com/lacework/terraform-aws-cloudtrail/commit/dc26bd1a04c2ac7751cc5bc69455858f600e921d))
---
# v1.0.1

## Documentation Updates
* docs: update examples to use v1.0 (#66) (Darren)([6e0e239](https://github.com/lacework/terraform-aws-cloudtrail/commit/6e0e2392c8f9984f8db61e2ca8af9ddc11cb4b32))
## Other Changes
* ci: version bump to v1.0.1-dev (Lacework)([75727a8](https://github.com/lacework/terraform-aws-cloudtrail/commit/75727a85e457bbfd7d068ea56e5cc4b1cb6b5a44))
---
# v1.0.0

## Features
* feat: ensure SNS topic is encrypted (Darren Murray)([12a6232](https://github.com/lacework/terraform-aws-cloudtrail/commit/12a62325a85b8e42c6ed6a50ad9ac9f008503349))
* feat: ensure resources adhere to Lacework compliance rules (#62) (Darren)([5880491](https://github.com/lacework/terraform-aws-cloudtrail/commit/5880491263a604521f0eaf6ce14fdd36083ed395))
## Documentation Updates
* docs: Fix incorrect use_existing_cloudtrail description (#60) (Darren)([35776f6](https://github.com/lacework/terraform-aws-cloudtrail/commit/35776f65c78b39219c126bb166a871de3cccb047))
* docs: Fix incorrect use_existing_access_log_bucket description (#61) (Darren)([670b81c](https://github.com/lacework/terraform-aws-cloudtrail/commit/670b81c82cf53bb4086a0c37c2c1956e13394234))
## Other Changes
* ci: version bump to v0.5.1-dev (Lacework)([8c52554](https://github.com/lacework/terraform-aws-cloudtrail/commit/8c525541dd610b78da98dc8343a56adc533df47c))
---
# v0.5.0

## Features
* feat: Use existing access log bucket option (#57) (loganjohnson-wk)([e2cb9a8](https://github.com/lacework/terraform-aws-cloudtrail/commit/e2cb9a830c2a74e4b98e75e661527c142afe2d56))
## Other Changes
* ci: version bump to v0.4.1-dev (Lacework)([c7772d0](https://github.com/lacework/terraform-aws-cloudtrail/commit/c7772d062817f686033157b66de2c0865e490c6c))
---
# v0.4.0

## Features
* feat: added support for server-side encryption on SQS (#54) (Alan Nix)([c276451](https://github.com/lacework/terraform-aws-cloudtrail/commit/c2764511b0229fd35e1ae696cd8f5779a0e96ffa))
## Bug Fixes
* fix: add tags to IAM Policy (#53) (rajgandhi9)([e6c2aae](https://github.com/lacework/terraform-aws-cloudtrail/commit/e6c2aaec75fab39e40b78191c0c768972e659343))
## Other Changes
* ci: version bump to v0.3.1-dev (Lacework)([3e3495c](https://github.com/lacework/terraform-aws-cloudtrail/commit/3e3495c55d543f654d93fbfb4bbff4d3c0411180))
---
# v0.3.0

## Features
* feat: parse bucket_name from bucket_arn (#51) (Michael Droessler)([7e08dc9](https://github.com/lacework/terraform-aws-cloudtrail/commit/7e08dc9681e342320f3c7568edba6082c21f3364))
## Documentation Updates
* docs: Include 'Github' as relevant issue link (#49) (Darren)([7a92fa8](https://github.com/lacework/terraform-aws-cloudtrail/commit/7a92fa8086c1722e2e247ea7f5168ae278e02984))
* docs: Add contributing documentation (#48) (Darren)([9ea0be9](https://github.com/lacework/terraform-aws-cloudtrail/commit/9ea0be9ac9ca4d21724d51c975f5a26a11dbcd62))
## Other Changes
* ci: version bump to v0.2.3-dev (Lacework)([6079c0f](https://github.com/lacework/terraform-aws-cloudtrail/commit/6079c0f18c0b2682dfe82eacd72a970d4b6b26f1))
---
# v0.2.2

## Bug Fixes
* fix(ci): ignore .terraform.lock.hcl files (#46) (Salim Afiune)([a704570](https://github.com/lacework/terraform-aws-cloudtrail/commit/a70457073f862ff7228fcfedeb4e803ff1a7d333))
* fix: output reference to local iam_role_name variable (#45) (Salim Afiune)([bf639ab](https://github.com/lacework/terraform-aws-cloudtrail/commit/bf639abf18cc34eea5523fabab7d69a9f5ba9cc8))
## Documentation Updates
* docs: fix for module reference in 'existing-encrypted-cloudtrail' (#40) (Alan Nix)([fb42d89](https://github.com/lacework/terraform-aws-cloudtrail/commit/fb42d897b8303c006552ecbf7a7bd108ca6be541))
## Other Changes
* chore: version bump to v0.2.2-dev (Lacework)([25fad2f](https://github.com/lacework/terraform-aws-cloudtrail/commit/25fad2fe87c25b7c562c194a5b74e7badf55f9bd))
* ci: sign lacework-releng commits (#43) (Salim Afiune)([4c66775](https://github.com/lacework/terraform-aws-cloudtrail/commit/4c66775acbfad026e2a70f7211a21f7598006613))
---
# v0.2.1

## Documentation Updates
* docs: updated example doc structure and version constraints (#34) (Alan Nix)([e790562](https://github.com/lacework/terraform-aws-cloudtrail/commit/e790562b5518fb32bdfec43497de8df788627c39))
## Other Changes
* chore: bump required version of TF to 0.12.31 (#37) (Scott Ford)([ffe0d5e](https://github.com/lacework/terraform-aws-cloudtrail/commit/ffe0d5e8cecdc05ab5b345a8835744182b9ed63a))
* chore: version bump to v0.2.1-dev (Lacework)([2eb3e7b](https://github.com/lacework/terraform-aws-cloudtrail/commit/2eb3e7b78727661fae916a16af3a8fe0dc01a5d6))
* ci: fix finding major versions during release (#35) (Salim Afiune)([c0acb1b](https://github.com/lacework/terraform-aws-cloudtrail/commit/c0acb1b329a2ead4de57c2b2f8d3a6331a55e2f9))
---
# v0.2.0

## Features
* feat: allow explicit use of an existing SNS topic (#30) (Alan Nix)([3c5a85d](https://github.com/lacework/terraform-aws-cloudtrail/commit/3c5a85d9a1ede1ae7a4e6db648e50b6e6c1772c2))
## Other Changes
* ci: update release scripts (#32) (Salim Afiune)([b109804](https://github.com/lacework/terraform-aws-cloudtrail/commit/b1098044da7494a4d1e575bacfc45f117ce21f3c))
* ci: Remove CircleCI in favor of CodeFresh (#31) (Darren)([e5ad1f6](https://github.com/lacework/terraform-aws-cloudtrail/commit/e5ad1f638ce9b3cbdcba4ad922aacd0b3d707eae))
---
# v0.1.7

## Bug Fixes
* fix: loosen up required version of Lacework provider (#27) (Alan Nix)([c7d44a9](https://github.com/lacework/terraform-aws-cloudtrail/commit/c7d44a973ae6480fc62a57cb7f85dad052f6eab8))
## Other Changes
* chore: loosen up version pinnings (Salim Afiune Maya)([8bbbd32](https://github.com/lacework/terraform-aws-cloudtrail/commit/8bbbd3220452875d6116842ce94c4fc44f1978d9))
* ci: switch releases to be own by Lacework releng ⚡ (Salim Afiune Maya)([0678609](https://github.com/lacework/terraform-aws-cloudtrail/commit/067860970f5cabf2e3a1692ce202a0c4261c1cdb))
---
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
