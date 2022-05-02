
#################################################
# IAM
#################################################

output "codebuild_iam_arn" {
  description = "The arn of the code build IAM role"
  value       = module.iam.codebuild_iam_arn
}

output "codepipeline_iam_arn" {
  description = "The arn of the code pipeline IAM role"
  value       = module.iam.codepipeline_iam_arn
}

output "esc_task_iam_arn" {
  description = "The arn of the ecs task execution IAM role"
  value       = module.iam.esc_task_iam_arn
}

#################################################
# SECURITY GROUPS
#################################################

output "ecs_sg_id" {
  description = "The id of the ecs service security group"
  value       = module.security_groups.ecs_sg_id
}
