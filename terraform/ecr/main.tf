#################################################
# SUPPORTING RESOURCES
#################################################

locals {
  ecr_tags = {}

  container_registry_list = [
    {
      "name"         = "something-technical-api"
      "immutable"    = false
      "tags"         = {}
      "scan_on_push" = false
    },
  ]
}

#################################################
# ECR REPOSITORY
#################################################
resource "aws_ecr_repository" "repository" {
  for_each = { for idx, record in local.container_registry_list : idx => record }


  name                 = each.value.name
  image_tag_mutability = each.value.immutable ? "IMMUTABLE" : "MUTABLE"

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  # merge all relevant tags
  tags = merge(var.global_tags, local.ecr_tags, each.value.tags)
}


#################################################
# REPOSITORY POLICIES
#################################################
