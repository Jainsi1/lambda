module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "stage_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true


  /* tags = {
    Terraform = "true"
    Environment = "dev"
  } */
}
 module "rds-sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "rds-security-group"
  description = "Security group for RDS"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["postgresql-tcp"]
  egress_rules        = ["all-all"]
}
module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "postgres"
  engine_version    = "14"
  family            = "postgres14" 
  instance_class    = "db.t4g.large"
  allocated_storage = 50
  publicly_accessible = var.publicly_accessible

  db_name  = "exampledb"
  username = "test"
  port     = "5432"
  password = "example123"

  iam_database_authentication_enabled = true

  multi_az               = true
  vpc_security_group_ids = [ module.rds-sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = true

  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

   /* tags = {
    Owner       = "user"
    Environment = "dev"
  }  */

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.public_subnets

   # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
}
module "ecs-dev" {
   source = "./module/ecs"
   depends_on=[ aws_ecs_cluster.example_cluster ]
   for_each = var.containers
   image_name = each.value.image_name
   container_name = each.value.container_name
   ecs_service_name = each.value.ecs_service_name 
   alb_name = each.value.alb_name
   internal = each.value.internal
   ecs_desired_count= each.value.ecs_desired_count
   container_port = each.value.container_port
   task_environment_variables = each.value.envs
   env_value = each.value.envs
   vpc_id = module.vpc.vpc_id
   pub_subnet_ids = module.vpc.public_subnets
   priv_subnet_ids = module.vpc.private_subnets
   cluster_arn = aws_ecs_cluster.example_cluster.id
   /* cert_arn = each.value.cert_arn  */
   /* repository_name = each.value.repository_name  */
 } 

resource "aws_ecs_cluster" "example_cluster" {
   name = var.cluster_name
}   
module "lambda_with_vpc" {
  source = "./module/lambda_with_s3"
  lambda_bucket = var.lambda_bucket
  function_name = var.function_name
  file_name = "${path.module}/module/lambda_with_s3/python/hello-python.py.zip"
  file_handler = var.file_handler
  runtime = var.runtime
  timeout = var.timeout
  memory_size = var.memory_size
  prv_subnet_ids = module.vpc.private_subnets
  vpc_lambda = module.vpc.vpc_id
  pub_subnet_ids = module.vpc.public_subnets
  load_balancer_name = var.load_balancer_name
  target_group_name = var.target_group_name
  envs = var.envs
} 