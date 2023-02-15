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
