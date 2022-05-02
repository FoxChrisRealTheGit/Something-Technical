# aws_rds_cluster
output "cluster_id" {
  description = "The ID of the cluster"
  value       = module.something_beta_db.rds_cluster_id
}

output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.something_beta_db.rds_cluster_endpoint
}

output "master_password" {
  description = "The master password"
  value       = module.something_beta_db.rds_cluster_master_password
  sensitive   = true
}

output "cluster_master_username" {
  description = "The master username"
  value       = module.something_beta_db.rds_cluster_master_username
  sensitive   = true
}


output "cluster_database_name" {
  description = "The cluster database name"
  value       = module.something_beta_db.rds_cluster_database_name
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.something_beta_db.security_group_id
}
