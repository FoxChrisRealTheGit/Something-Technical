#################################################
# NETWORKING
#################################################

variable "vpc_id" {}

variable "subnets" {}

variable "alb_arn" {}

#################################################
# INPUTS
#################################################

variable "ecs_service_sg" {}

variable "ecs_task_iam_arn" {}

# this is the input parameter of the module
variable "cluster_name" {}

variable "cluster_id" {}

variable "tags" {}

