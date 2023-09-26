#!/bin/bash
#
# Name::        ci_tests.sh
# Description:: Use this script to run ci tests of this repository
# Author::      Salim Afiune Maya (<afiune@lacework.net>)
#
set -eou pipefail

readonly project_name=terraform-aws-cloudtrail

TEST_CASES=(
  examples/complete-cloudtrail-access-logs
  examples/complete-cloudtrail-unencrypted
  examples/complete-cloudtrail-versioning
  examples/complete-cloudtrail
  examples/complete-cloudtrail-access-logs-with-object-level-logging
  examples/cloudtrail-existing-kms-key
  examples/consolidated-existing-cloudtrail-in-another-account-datadog-co-existance
  examples/consolidated-cloudtrail-multiple-lacework-tenants
  examples/consolidated-cloudtrail
  examples/existing-cloudtrail-end-to-end-encryption
  examples/existing-cloudtrail-s3-encryption
  examples/existing-cloudtrail-s3-notifications
  examples/existing-cloudtrail-iam-role
  examples/existing-cloudtrail
  examples/existing-cloudtrail-without-sns-topic
)

log() {
  echo "--> ${project_name}: $1"
}

warn() {
  echo "xxx ${project_name}: $1" >&2
}

write_aws_profiles() {
  log "Writing AWS profiles"
  if [ ! -d "~/.aws" ]; then
    mkdir ~/.aws
    echo "[main-account]" > ~/.aws/credentials
    echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> ~/.aws/credentials
    echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
    echo "aws_session_token = $AWS_SESSION_TOKEN" >> ~/.aws/credentials
    echo "[sub-account-1]" >> ~/.aws/credentials
    echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> ~/.aws/credentials
    echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
    echo "aws_session_token = $AWS_SESSION_TOKEN" >> ~/.aws/credentials
    echo "[sub-account-2]" >> ~/.aws/credentials
    echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> ~/.aws/credentials
    echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
    echo "aws_session_token = $AWS_SESSION_TOKEN" >> ~/.aws/credentials
    chmod 600 ~/.aws/credentials
  fi
}

integration_tests() {
  for tcase in ${TEST_CASES[*]}; do
    log "Running tests at $tcase"
    ( cd $tcase || exit 1
      terraform init
      terraform validate
      terraform plan
    ) || exit 1
  done
}

lint_tests() {
  log "terraform fmt check"
  terraform fmt -check
}

sec_tests() {
  # TODO: replace with `lacework iac tf-scan tfsec -m MEDIUM`
  tfsec -m MEDIUM
}

main() {
  write_aws_profiles
  lint_tests
  integration_tests
  sec_tests
}

main || exit 99
