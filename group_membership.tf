# Put database users in the appropriate group.
resource "aws_iam_user_group_membership" "read_only_users" {
  provider = aws.users
  for_each = toset([for username, attributes in var.users : username if attributes["role"] == "read_only"])

  groups = [
    aws_iam_group.read_only_users.name
  ]

  user = each.key
}

resource "aws_iam_user_group_membership" "read_write_users" {
  provider = aws.users
  for_each = toset([for username, attributes in var.users : username if attributes["role"] == "read_write"])

  groups = [
    aws_iam_group.read_write_users.name
  ]

  user = each.key
}
