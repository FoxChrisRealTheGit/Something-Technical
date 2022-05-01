output "repository" {
  description = "All outputs of the repository."
  value       = try(aws_ecr_repository.repository, null)
}
