output "cluster_id" {
  description = "The ID of the cluster"
  value       = aws_ecs_cluster.something_cluster.id
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = "something-cluster"
}


output "api_service_name" {
  description = "The name of the api service"
  value       = module.api_service.api_service_name
}
