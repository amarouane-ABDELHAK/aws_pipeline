data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


resource "aws_iam_role" "codepipeline-executor" {
  name                  = "${var.prefix}-pipeline-role-executor"
  description           = "Pipeline IAM Role Executor"
  assume_role_policy    = data.aws_iam_policy_document.codepipeline_assume_policy_document.json
  force_detach_policies = var.force_detach_policies
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = {
    Name = "${var.prefix} IAM role for pipeline"
  }
}

resource "aws_iam_role" "codebuilde-executor" {
  name                  = "${var.prefix}-codebuild-role-executor"
  description           = "codebuild IAM Role Executor"
  assume_role_policy    = data.aws_iam_policy_document.codebuild_assume_policy_document.json
  force_detach_policies = var.force_detach_policies
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = {
    Name = "${var.prefix} IAM role for codebuild"
  }
}


resource "aws_iam_role_policy" "codebuild-role-policy" {
  name_prefix = "${var.prefix}-codebuild-policy-executor"
  role        = aws_iam_role.codebuilde-executor.id
  policy      = data.aws_iam_policy_document.codepipeline_policy_document.json
}

resource "aws_iam_role_policy" "codepipeline-role-policy" {
  name_prefix = "${var.prefix}-codepipeline-policy-executor"
  role        = aws_iam_role.codepipeline-executor.id
  policy      = data.aws_iam_policy_document.codepipeline_policy_document.json
}

resource "aws_iam_role_policy_attachment" "codebuild-role-policy-attachment" {
  for_each   = var.iam_role_additional_arn_policies
  policy_arn = each.value
  role       = aws_iam_role.codebuilde-executor.id
}