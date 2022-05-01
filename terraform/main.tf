#################################################
# SUPPORTING RESOURCES
#################################################

locals {
  application_tags = {
    environment = var.environment
  }
}


#################################################
# STEP - 1
#################################################

# networking module
module "networking" {
  source = "./networking"

  name               = "${var.environment}_${var.region}_vpn"
  cidr               = "10.100.0.0/16" # /16 is the max size
  azs                = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true

  #
  tags = merge(local.application_tags, var.global_tags)
}


#################################################
# STEP - 2 - Access
#################################################
# 
module "access" {
  source = "./access"
  #
  depends_on = [module.networking]
  #
  vpc_id      = module.networking.vpc_id
  subnet_arns = module.networking.private_subnet_arns
  #
  s3_artifact_arn = var.s3_artifact_arn
  gh_codestar_con = var.gh_codestar_con
  #
  tags = merge(local.application_tags, var.global_tags)
}

#################################################
# STEP - 3
#################################################
# container registry module
module "container_registry" {
  source = "./ecr"

  #
  global_tags = merge(local.application_tags, var.global_tags)
}

# databases module
module "databases" {
  source = "./rds"

  # networking injects
  vpc_id      = module.networking.vpc_id
  subnets     = module.networking.private_subnets
  cidr_blocks = module.networking.private_subnets_cidr_blocks

  #
  tags = merge(local.application_tags, var.global_tags)
}

# load balancers module
module "load_balancer" {
  source = "./alb"

  # networking injects
  vpc_id             = module.networking.vpc_id
  subnets            = module.networking.public_subnets
  cidr_blocks        = module.networking.private_subnets_cidr_blocks
  vpc_security_group = module.networking.default_security_group

  #
  tags = merge(local.application_tags, var.global_tags)
}


#################################################
# STEP - 4
#################################################

# ecs module
module "ecs" {
  source = "./ecs"

  depends_on = [module.s3_storage]

  alb_arn = module.load_balancer.something_alb_arn

  #ecs variables
  ecs_task_iam_arn = module.access.esc_task_iam_arn
  ecs_service_sg   = module.access.ecs_sg_id
  #
  region = var.region

  #networking injects
  vpc_id      = module.networking.vpc_id
  subnets     = module.networking.private_subnets
  cidr_blocks = module.networking.private_subnets_cidr_blocks

  #
  tags = merge(local.application_tags, var.global_tags)
}

#################################################
# STEP - 6
#################################################


# pipelines module
module "pipelines" {
  source = "./pipelines"

  depends_on = [module.ecs, module.container_registry]

  #
  db_host = module.databases.cluster_endpoint
  db_name = module.databases.cluster_database_name
  db_user = module.databases.cluster_master_username
  db_pass = module.databases.master_password

  s3_upload_bucket = module.s3_storage.something_image_bucket_name

  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnets
  security_group_ids = tolist([module.networking.default_security_group, module.databases.security_group_id])
  # pipeline variables
  s3_artifact_arn      = var.s3_artifact_arn
  s3_artifact_location = var.s3_artifact_location
  codebuild_iam        = module.access.codebuild_iam_arn
  codepipeline_iam     = module.access.codepipeline_iam_arn
  gh_codestar_con      = var.gh_codestar_con
  #
  ecs_cluster_name = module.ecs.cluster_name
  # ecs_web_service_name      = module.ecs[0].web_service_name
  ecs_api_service_name      = module.ecs.api_service_name
  ecs_consumer_service_name = module.ecs.scheduler_service_name

  #
  tags = merge(local.application_tags, var.global_tags)
}
