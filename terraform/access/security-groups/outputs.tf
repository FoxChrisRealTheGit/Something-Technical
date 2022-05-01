output "ecs_sg_id" {
  description = "The id of the ecs service security group"
  value       = module.ecs_service_sg.ecs_sg_id
}
