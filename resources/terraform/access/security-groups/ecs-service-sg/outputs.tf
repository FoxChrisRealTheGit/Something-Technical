output "ecs_sg_id" {
  description = "The id of the ecs service security group"
  value       = aws_security_group.allow_http.id
}
