#################################################
# SUPPORTING RESOURCES
#################################################

locals {
  networking_tags = {}
}


#################################################
# VPC
#################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name = var.name
  cidr = var.cidr

  manage_default_route_table = true

  default_route_table_tags = { DefaultRouteTable = true }

  enable_dns_hostnames = false
  enable_dns_support   = true

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = merge(var.tags, local.networking_tags)
}

