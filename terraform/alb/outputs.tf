output "something_alb_arn" {
  description = "The ARN of the  alb"
  value       = module.something_alb.lb_arn
}

output "something_alb_dns_name" {
  description = "The dns name of the something alb"
  value       = module.something_alb.lb_dns_name
}

output "something_alb_zone_id" {
  description = "The zone id of the something alb"
  value       = module.something_alb.lb_zone_id
}
