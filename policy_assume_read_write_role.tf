# IAM policy document that allows assumption of the WAS DB read-write role in the
# User Services account
data "aws_iam_policy_document" "assume_userservices_was_db_read_write_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      data.terraform_remote_state.userservices_was_db_staging.outputs.read_write_role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_userservices_was_db_read_write_role" {
  provider = aws.users

  description = var.assume_userservices_was_db_read_write_policy_description
  name        = var.assume_userservices_was_db_read_write_policy_name
  policy      = data.aws_iam_policy_document.assume_userservices_was_db_read_write_role_doc.json
}
