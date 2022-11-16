output "codebuild_role_arn" {
  value = aws_iam_role.codebuilde-executor.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline-executor.arn
}