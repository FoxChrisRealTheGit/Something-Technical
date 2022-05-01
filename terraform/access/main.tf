#################################################
# SUPPORTING RESOURCES
#################################################

#################################################
# IAM
#################################################

module "iam" {
  source = "./iam"

  subnet_arns = var.subnet_arns
  #
  s3_artifact_arn = var.s3_artifact_arn
  gh_codestar_con = var.gh_codestar_con
  #
  tags = var.tags
}

#################################################
# SECURITY GROUP
#################################################

module "security_groups" {
  source = "./security-groups"

  vpc_id = var.vpc_id
  #
  tags = var.tags
}
