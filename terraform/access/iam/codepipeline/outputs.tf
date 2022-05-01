output "codepipeline_iam_arn" {
  description = "The arn of the code pipeline IAM role"
  value       = aws_iam_role.code_pipeline.arn
}
