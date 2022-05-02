#################################################
# SUPPORTING RESOURCES
#################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "alb-sg-something-techincal"
  description = "Security group for example usage with ALB"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

#################################################
# ALB
#################################################

module "something_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.3.0"

  name = "something-alb"

  load_balancer_type = "application"


  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = [var.vpc_security_group, module.security_group.security_group_id]

  tags = var.tags
}

