#################################################
# SUPPORTING RESOURCES
#################################################

#################################################
# CODE BUILD
#################################################

module "codebuild_iam" {
  source = "./codebuild"

  subnet_arns = var.subnet_arns
  #
  s3_artifact_arn = var.s3_artifact_arn
  #
  tags = var.tags
}

#################################################
# CODE PIPELINE
#################################################

module "codepipeline_iam" {
  source = "./codepipeline"
  #
  s3_artifact_arn = var.s3_artifact_arn
  gh_codestar_con = var.gh_codestar_con
  #
  tags = var.tags
}

#################################################
# ECS TASK EXECUTION
#################################################

module "ecs_task_iam" {
  source = "./ecstaskexecution"

  #
  tags = var.tags
}
