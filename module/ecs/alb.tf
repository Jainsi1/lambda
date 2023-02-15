# resource "aws_lb_target_group" "ecs-lb-target" {
#   name = "ecs-lb-target-group"
#   port = 80
#   protocol = "HTTP"
#   target_type = "ip"
#   vpc_id = module.vpc.vpc_id
# }
  module "alb" {
    source = "terraform-aws-modules/alb/aws"
    name = var.alb_name
    load_balancer_type = "application"
    internal = var.internal
    vpc_id = var.vpc_id
    subnets = var.pub_subnet_ids
    security_groups = [module.alb-sg.security_group_id]
    
    target_groups = [
      {
          name_prefix = "target"
          backend_protocol = "HTTP"
          backend_port = 80
          target_type = "ip"
          health_check = {
          matcher = "200-499"
      }
      }
    ]

    http_tcp_listeners = [
      {
          port = 80
          protocol = "HTTP"
          target_group_index = 0
           
           
          default_action =  {
            type = "redirect"

             redirect = {
               port        = "443"
               protocol    = "HTTPS"
               status_code = "HTTP_301"
             }
          }
      }
    ]
  }

    /* https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.cert_arn  
       target_group_index = 0
    }
   ]  */

