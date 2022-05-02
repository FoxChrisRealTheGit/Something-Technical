#################################################
# SUPPORTING RESOURCES
#################################################


#################################################
# PIPELINE ARTIFACT LOCATION
#################################################

resource "aws_s3_bucket" "pipeline_bucket" {
  bucket        = "something-pipeline-artifact-bucket-5623897"
  acl           = "private"
  force_destroy = false
  tags          = var.tags
}
