
resource "aws_security_group" "allow_tls" {
  name        = "${var.function_name}_allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_lambda

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
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

 
}

module "alb-sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "alb-sg-ecs-${var.function_name}"
  description = "Security group for ecs usage with ALB"
  vpc_id      = var.vpc_lambda

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp","https-443-tcp"]
  egress_rules        = ["all-all"]
  # depends_on = [aws_cloudwatch_log_group.example_cw_log_group]
}