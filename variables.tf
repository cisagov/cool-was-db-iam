# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "users" {
  type        = map(object({ role = string }))
  description = "A map whose keys are the usernames of each database user and whose values are a map containing supported user attributes.  The only currently-supported attribute is \"role\" (string).  The only currently-supported roles are \"read_only\" and \"read_write\".  Example: { \"firstname1.lastname1\" = { \"role\" = \"read_only\" }, \"firstname2.lastname2\" = { \"role\" = \"read_write\" } }"
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_userservices_was_db_read_only_policy_description" {
  default     = "Allows assumption of the WAS DB read-only role in the User Services account."
  description = "The description of the IAM policy that allows assumption of the WAS DB read-only role in the User Services account."
  type        = string
}

variable "assume_userservices_was_db_read_only_policy_name" {
  default     = "AssumeUserServicesWASDBReadOnlyRole"
  description = "The name of the IAM policy that allows assumption of the WAS DB read-only role in the User Services account."
  type        = string
}

variable "assume_userservices_was_db_read_write_policy_description" {
  default     = "Allows assumption of the WAS DB read-write role in the User Services account."
  description = "The description of the IAM policy that allows assumption of the WAS DB read-write role in the User Services account."
  type        = string
}

variable "assume_userservices_was_db_read_write_policy_name" {
  default     = "AssumeUserServicesWASDBReadWriteRole"
  description = "The name of the IAM policy that allows assumption of the WAS DB read-write role in the User Services account."
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  type        = string
}

variable "read_only_users_group_name" {
  default     = "was_db_read_only_users"
  description = "The name of the IAM group for WAS database users with read-only access."
  type        = string
}

variable "read_write_users_group_name" {
  default     = "was_db_read_write_users"
  description = "The name of the IAM group for WAS database users with read-write access."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
