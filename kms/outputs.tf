output "codepipeline_alias_kms_key_arn" {
  value = aws_kms_alias.my_kms_key.arn
}