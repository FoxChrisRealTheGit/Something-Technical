# 
output "pipeline_artifact_bucket_location" {
  description = "The location of the s3 pipeline bucket"
  value       = aws_s3_bucket.pipeline_bucket.id
}
# 
output "pipeline_artifact_bucket_arn" {
  description = "The arn of the s3 pipeline bucket"
  value       = aws_s3_bucket.pipeline_bucket.arn
}
