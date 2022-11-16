
data "aws_s3_bucket" "codepipline_bucket" {
  bucket = var.codepipline_bucket_name
}



resource "aws_codepipeline" "codepipeline" {
  name     = "${var.prefix}-codepipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = data.aws_s3_bucket.codepipline_bucket.bucket
    type     = "S3"

    encryption_key {
      id   = var.codepipeline_alias_kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["artifact"]

      configuration = {
        ConnectionArn    = "arn:aws:codestar-connections:${var.region}:${var.account_id}:connection/${var.connection_id}"
        FullRepositoryId = "${var.github_owner_name}/${var.github_reponame}"
        BranchName       = var.branch_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["artifact"]

      configuration = {
        ProjectName = aws_codebuild_project.build_pipeline.name
      }
    }
  }

}






resource "aws_codebuild_source_credential" "github_token" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.github_token
}



resource "aws_codebuild_project" "build_pipeline" {
  name         = "${var.prefix}-build-pipeline"
  service_role = var.codebuild_role_arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    dynamic "environment_variable" {
      for_each = var.env_vars
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }

  }
  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.github_owner_name}/${var.github_reponame}"
    git_clone_depth = 1
  }
}



