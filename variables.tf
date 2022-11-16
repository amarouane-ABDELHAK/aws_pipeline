variable "codepipline_bucket_name" {}
variable "prefix" {}
variable "github_owner_name" {}
variable "github_reponame" {}
variable "aws_region" {}
variable "aws_profile" {
  default = null
}
variable "connection_id" {}
variable "iam_role_permissions_boundary" {
  default = null
}
variable "branch_name" {}
variable "env_vars" {
  type = map(string)
}

variable "iam_role_additional_arn_policies" {
  type = map(string)
}
variable "account_id" {}