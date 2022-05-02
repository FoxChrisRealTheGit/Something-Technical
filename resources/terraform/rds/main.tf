#################################################
# SUPPORTING RESOURCES
#################################################

resource "random_password" "master" {
  special = false
  length  = 12
}



#################################################
# SECURITY GROUPS
#################################################

resource "aws_security_group" "allow_everything" {
  name        = "allow_pg_everything"
  description = "Allow all the things for this rds"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow all the things for this rds"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

#################################################
# AMAZON AURORA POSTGRES
#################################################

module "something_alpha_db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "5.2.0"

  name           = "alpha-something-pg"
  engine         = "aurora-postgresql"
  engine_version = "11.9"
  engine_mode    = "serverless"

  vpc_id  = var.vpc_id
  subnets = var.subnets


  create_security_group = false

  replica_scale_enabled = false
  replica_count         = 0

  iam_database_authentication_enabled = false
  password                            = random_password.master.result
  create_random_password              = false
  allowed_security_groups             = [aws_security_group.allow_everything.id]
  vpc_security_group_ids              = [aws_security_group.allow_everything.id]
  allowed_cidr_blocks                 = var.cidr_blocks

  database_name = "something_alpha"

  deletion_protection = false
  storage_encrypted   = true
  apply_immediately   = true
  skip_final_snapshot = true
  monitoring_interval = 60

  scaling_configuration = {
    auto_pause               = true
    min_capacity             = 2
    max_capacity             = 16
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  tags = var.tags
}
