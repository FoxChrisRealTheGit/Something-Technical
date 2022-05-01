
#################################################
# ENVIRONMENT VARIABLES
#################################################

variable "environment" {
  description = "What environment this is in"
  type        = string
  default     = "DEV"
}

#################################################
# INPUTS
#################################################

# for logging in and what not

variable "db_host" {}

variable "db_name" {}

variable "db_user" {}

variable "db_pass" {}

variable "s3_upload_bucket" {}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "security_group_ids" {}

variable "ecs_cluster_name" {}

# variable "ecs_web_service_name" {}

variable "ecs_api_service_name" {}

variable "ecs_consumer_service_name" {}



variable "tags" {
  default     = {}
  description = "Tags bubbling down"
  type        = map(string)
}


#################################################
# PIPELINE VARIABLES
#################################################

variable "s3_artifact_arn" {}

variable "s3_artifact_location" {}

variable "codebuild_iam" {}

variable "codepipeline_iam" {}

variable "gh_codestar_con" {}
