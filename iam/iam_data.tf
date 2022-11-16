
data "aws_iam_policy_document" "codebuild_assume_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type        = "Service"
    }
}
}



data "aws_iam_policy_document" "codepipeline_assume_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
}
}

data "aws_iam_policy_document" "codepipeline_policy_document" {
    statement {
    effect = "Allow"
    actions = [
       "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject",
        "s3:ListObjectsV2",
        "s3:ListBucket"
    ]
    resources = [
      var.codepipeline_bucket_arn,
      "${var.codepipeline_bucket_arn}/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
       "kms:*"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
       "codestar-connections:UseConnection"
    ]
    resources = [
      "*",
    ]
  }
    statement {
    effect = "Allow"
    actions = [
       "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
    ]
    resources = [
      "*",
    ]
  }

      statement {
    effect = "Allow"
    actions = [
        "appconfig:StartDeployment",
        "appconfig:GetDeployment",
        "appconfig:StopDeployment"
    ]
    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
  "codecommit:GetRepository"
    ]
    resources = [
      "*",
    ]
  }

    statement {
    effect = "Allow"
    actions = [
  "logs:*"
    ]
    resources = [
      "*",
    ]
  }
}