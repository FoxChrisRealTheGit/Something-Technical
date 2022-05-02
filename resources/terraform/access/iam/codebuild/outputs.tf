output "codebuild_iam_arn" {
  description = "The arn of the code build IAM role"
  value       = aws_iam_role.code_build.arn
}
