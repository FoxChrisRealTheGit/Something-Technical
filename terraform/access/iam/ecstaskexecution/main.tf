#################################################
# SUPPORTING RESOURCES
#################################################

#################################################
# TASK EXECUTION ROLE
#################################################

resource "aws_iam_role" "ecs_task" {
  name = "ecsTaskExecutionRole-tf"

  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonRDSFullAccess", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess", "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicReadOnly"]

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
