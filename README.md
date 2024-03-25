# cool-was-db-iam #

[![GitHub Build Status](https://github.com/cisagov/cool-was-db-iam/workflows/build/badge.svg)](https://github.com/cisagov/cool-was-db-iam/actions)

This project is used to manage IAM permissions for COOL users that are
allowed to read from and write to the
[COOL WAS database](https://github.com/cisagov/cool-userservices-was-db).

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [backend.tf](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [backend.tf](backend.tf)).
- Access to all of the Terraform remote states specified in
  [remote_states.tf](remote_states.tf).
- User accounts for all users must have been created previously.  We
  recommend using the
  [`cisagov/cool-users-non-admin`](https://github.com/cisagov/cool-users-non-admin)
  repository to create users.
- The WAS database and related access roles must have been created previously
  via the
  [`cisagov/cool-userservices-was-db`](https://github.com/cisagov/cool-userservices-was-db)
  repository.

## Usage ##

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
  variables (see [Inputs](#inputs) below for details):

  ```hcl
  users = {
  "firstname1.lastname1" = { "role" = "read_only" },
  "firstname2.lastname2" = { "role" = "read_write" },
  }
  ```

1. Run the command `terraform init`.
1. Run the command `terraform apply -var-file=<workspace_name>.tfvars`.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |
| aws.users | ~> 4.9 |
| terraform | n/a |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_group.read_only_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group.read_write_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.assume_userservices_was_db_read_only_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.assume_userservices_was_db_read_write_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.assume_userservices_was_db_read_only_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.assume_userservices_was_db_read_write_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.read_only_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_group_membership.read_write_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_userservices_was_db_read_only_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_userservices_was_db_read_write_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.master](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.users](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.userservices_was_db_production](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.userservices_was_db_staging](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_userservices\_was\_db\_read\_only\_policy\_description | The description of the IAM policy that allows assumption of the WAS DB read-only role in the User Services account. | `string` | `"Allows assumption of the WAS DB read-only role in the User Services account."` | no |
| assume\_userservices\_was\_db\_read\_only\_policy\_name | The name of the IAM policy that allows assumption of the WAS DB read-only role in the User Services account. | `string` | `"AssumeUserServicesWASDBReadOnlyRole"` | no |
| assume\_userservices\_was\_db\_read\_write\_policy\_description | The description of the IAM policy that allows assumption of the WAS DB read-write role in the User Services account. | `string` | `"Allows assumption of the WAS DB read-write role in the User Services account."` | no |
| assume\_userservices\_was\_db\_read\_write\_policy\_name | The name of the IAM policy that allows assumption of the WAS DB read-write role in the User Services account. | `string` | `"AssumeUserServicesWASDBReadWriteRole"` | no |
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| read\_only\_users\_group\_name | The name of the IAM group for WAS database users with read-only access. | `string` | `"was_db_read_only_users"` | no |
| read\_write\_users\_group\_name | The name of the IAM group for WAS database users with read-write access. | `string` | `"was_db_read_write_users"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| users | A map whose keys are the usernames of each database user and whose values are a map containing supported user attributes.  The only currently-supported attribute is "role" (string).  The only currently-supported roles are "read\_only" and "read\_write".  Example: { "firstname1.lastname1" = { "role" = "read\_only" }, "firstname2.lastname2" = { "role" = "read\_write" } } | `map(object({ role = string }))` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| read\_only\_users\_group | The IAM group for WAS database users with read-only access. |
| read\_write\_users\_group | The IAM group for WAS database users with read-write access. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
