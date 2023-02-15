resource "aws_lb_target_group" "main" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_lambda
  target_type = "lambda"
  # health_check {
  #   enabled  = true
  #   protocol = "HTTP"
  #   matcher = "200-499"
  # }
}

resource "aws_lambda_alias" "live" {
  name = "live"
  description = "Live alias"
  function_name = aws_lambda_function.func.arn
  function_version = aws_lambda_function.func.version
}

resource "aws_lb" "main" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"

   subnets = var.pub_subnet_ids
   security_groups = [module.alb-sg.security_group_id]
  
}
resource "aws_lambda_permission" "alb" {
  statement_id = "AllowExecutionFromALB"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.function_name
  principal = "elasticloadbalancing.amazonaws.com"
 // qualifier = aws_lambda_alias.live.name
  source_arn = aws_lb_target_group.main.arn
}
resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id = aws_lambda_alias.live.function_name
  depends_on = [ aws_lambda_permission.alb ]
}
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}