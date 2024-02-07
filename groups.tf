# An IAM group for read-only database users
resource "aws_iam_group" "read_only_users" {
  provider = aws.users

  name = var.read_only_users_group_name
}

# Attach the correct policy to the read-only database users group
resource "aws_iam_group_policy_attachment" "assume_userservices_was_db_read_only_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.read_only_users.name
  policy_arn = aws_iam_policy.assume_userservices_was_db_read_only_role.arn
}

# An IAM group for read-write database users
resource "aws_iam_group" "read_write_users" {
  provider = aws.users

  name = var.read_write_users_group_name
}

# Attach the correct policy to the read-write database users group
resource "aws_iam_group_policy_attachment" "assume_userservices_was_db_read_write_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.read_write_users.name
  policy_arn = aws_iam_policy.assume_userservices_was_db_read_write_role.arn
}
