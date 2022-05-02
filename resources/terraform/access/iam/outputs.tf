
output "codebuild_iam_arn" {
  description = "The arn of the code build IAM role"
  value       = module.codebuild_iam.codebuild_iam_arn
}

output "codepipeline_iam_arn" {
  description = "The arn of the code pipeline IAM role"
  value       = module.codepipeline_iam.codepipeline_iam_arn
}

output "esc_task_iam_arn" {
  description = "The arn of the ecs task execution IAM role"
  value       = module.ecs_task_iam.ecs_task_iam_role
}
