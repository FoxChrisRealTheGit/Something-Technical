#################################################
# SUPPORTING RESOURCES
#################################################

resource "aws_iam_user" "upload_user" {
  name = "somethingUploadUser"

  tags = var.tags
}

resource "aws_iam_access_key" "upload_user" {
  user = aws_iam_user.upload_user.name
}

resource "aws_iam_user_policy" "upload_user" {
  name = "TFapis3SuperUser"
  user = aws_iam_user.upload_user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}




#################################################
# CODE BUILD
#################################################

resource "aws_codebuild_project" "code_build" {
  name         = "something_api_code_build"
  service_role = var.iamRole

  # cache {
  #   location = var.s3BucketName
  #   type     = "S3"
  # }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_LARGE"
    image           = "aws/codebuild/standard:2.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "DBHOST"
      value = var.db_host
    }

    environment_variable {
      name  = "DBNAME"
      value = var.db_name
    }

    environment_variable {
      name  = "DBUSER"
      value = var.db_user
    }

    environment_variable {
      name  = "DBPASS"
      value = var.db_pass
    }

    environment_variable {
      name  = "PORT"
      value = 80
    }

  }




  source {
    type = "CODEPIPELINE"
  }

  tags = var.tags
}

#################################################
# CODE PIPELINE
#################################################

resource "aws_codepipeline" "codepipeline" {
  name     = "something-api-pipeline"
  role_arn = var.pipeline_iam

  depends_on = [
    aws_codebuild_project.code_build
  ]

  artifact_store {
    location = var.s3BucketName
    type     = "S3"

  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.gh_codestar_con
        FullRepositoryId = "something-technical/something-api"
        BranchName       = var.environment == "DEV" ? "dev" : var.environment == "QA" ? "qa" : var.environment == "PROD" ? "main" : "dev"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.code_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName = var.api_ecs_cluster_name
        ServiceName = var.ecs_api_service_name
      }
    }
  }

  tags = var.tags
}
