output "read_only_users_group" {
  description = "The IAM group for WAS database users with read-only access."
  value       = aws_iam_group.read_only_users
}

output "read_write_users_group" {
  description = "The IAM group for WAS database users with read-write access."
  value       = aws_iam_group.read_write_users
}
