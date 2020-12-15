# Consolidated CloudTrail - Multiple Lacework Accounts

This example configures a consolidated cloudtrail on three AWS accounts, one main
account that owns the consolidated CloudTrail and two sub-accounts where we configure
sub-tails to point to the main trail from the main account.

The only difference from the `consolidated-cloudtrail` example is that here we configure
the Lacework integration at the Organization level and map the AWS accounts to Lacework
sub-accounts via the `org_account_mappings` field.
