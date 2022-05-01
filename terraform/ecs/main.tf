#################################################
# SUPPORTING RESOURCES
#################################################

#################################################
# STEP 1 - Cluster
#################################################

resource "aws_ecs_cluster" "something_cluster" {
  name = "something-cluster"

  capacity_providers = ["FARGATE"]

  tags = var.tags
}

#################################################
# ECS TASK DEF
#################################################

resource "aws_ecs_task_definition" "api_def" {
  family                   = "something_api_def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = var.ecs_task_iam_arn
  execution_role_arn       = var.ecs_task_iam_arn
  container_definitions    = <<TASK_DEFINITION
 
[
    {
        "cpu": 512,
        "essential": true,
        "image": "751333783788.dkr.ecr.us-east-2.amazonaws.com/something-api:latest",
        "memory": 1024,
        "name": "something-api",
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ]
    }
]
TASK_DEFINITION

}

#################################################
# LB TARGET GROUP
#################################################

resource "aws_lb_target_group" "something_api" {
  name        = "something-api-tg"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/health"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = var.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-2:751333783788:certificate/97909895-ca83-4e2b-812e-235d2bc152bc"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.something_api.arn
  }
}


resource "aws_lb_listener_rule" "something_api" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.something_api.arn
  }

  condition {
    path_pattern {
      values = ["/api*"]
    }
  }
}


#################################################
# ECS SERVICE
#################################################

resource "aws_ecs_service" "api_service" {

  depends_on = [
    aws_ecs_task_definition.api_def
  ]

  name            = "something_api_service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.api_def.arn
  desired_count   = 1

  launch_type = "FARGATE"

  health_check_grace_period_seconds = 30

  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.ecs_service_sg]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.something_api.arn
    container_name   = "something-api"
    container_port   = 80
  }

}
