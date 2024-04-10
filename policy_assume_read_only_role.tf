# IAM policy document that allows assumption of the WAS DB read-only role in the
# User Services staging and production accounts
data "aws_iam_policy_document" "assume_userservices_was_db_read_only_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    effect = "Allow"

    resources = [
      data.terraform_remote_state.userservices_was_db_staging.outputs.read_only_role.arn,
      data.terraform_remote_state.userservices_was_db_production.outputs.read_only_role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_userservices_was_db_read_only_role" {
  provider = aws.users

  description = var.assume_userservices_was_db_read_only_policy_description
  name        = var.assume_userservices_was_db_read_only_policy_name
  policy      = data.aws_iam_policy_document.assume_userservices_was_db_read_only_role_doc.json
}
