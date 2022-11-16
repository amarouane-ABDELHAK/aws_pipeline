resource "aws_kms_key" "my_kms_key" {
description             = "${var.prefix} KMS key to test data pipeline"
}

resource "aws_kms_alias" "my_kms_key" {
  target_key_id = aws_kms_key.my_kms_key.id
  name = "alias/${var.prefix}-codepipeline-key"
}