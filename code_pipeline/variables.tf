variable "codepipline_bucket_name" {}

variable "codepipeline_role_arn" {

}

variable "prefix" {

}

variable "codepipeline_alias_kms_key_arn" {

}


variable "github_owner_name" {}
variable "github_reponame" {}

variable "codebuild_role_arn" {
}

variable "region" {
}
variable "account_id" {
}
variable "connection_id" {
}
variable "branch_name" {

}

variable "env_vars" {
  type = map(string)
}