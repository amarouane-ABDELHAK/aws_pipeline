terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
}


module "kms" {
  source = "./kms"
  prefix = var.prefix
}



module "iam_codepipeline" {
  source = "./iam"
  codepipeline_bucket_arn = "arn:aws:s3:::${var.codepipline_bucket_name}"
  iam_role_additional_arn_policies = var.iam_role_additional_arn_policies
  iam_role_permissions_boundary = var.iam_role_permissions_boundary
  prefix = var.prefix
}

module "codepipeline" {
   source = "./code_pipeline"
   account_id = var.account_id
   codebuild_role_arn = module.iam_codepipeline.codebuild_role_arn
   codepipeline_alias_kms_key_arn = module.kms.codepipeline_alias_kms_key_arn
   codepipeline_role_arn = module.iam_codepipeline.codepipeline_role_arn
   codepipline_bucket_name = var.codepipline_bucket_name
   connection_id = var.connection_id
   prefix = var.prefix
   region = var.aws_region
   branch_name = var.branch_name
   env_vars = var.env_vars
   github_owner_name = var.github_owner_name
   github_reponame = var.github_reponame
 }

