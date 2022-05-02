
output "ecs_task_iam_role" {
  description = "The ARN of the ecs task execution role"
  value       = aws_iam_role.ecs_task.arn
}
