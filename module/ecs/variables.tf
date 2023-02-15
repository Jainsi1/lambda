# variable "launch_type" {}
# variable "network_type" {}
# variable "operating_system" {}

# variable "alb_type" {}
# variable "target_group_prefix" {}
# variable "backend_protocol" {}
# variable "backend_port" {}
# variable "lb_target_type" {}
# variable "listeners_port" {}
# variable "listeners_protocol" {}
# variable "target_group_index" {}
# # variable "alb_sg_name" {}
# variable "alb_sg_desc" {}
# variable "alb_sg_cidr" {}
# variable "alb_sg_ingress_rules" {}
# variable "alb_sg_engress_rules" {}
# # variable "ecs_sg_name" {}
# variable "ecs_sg_desc" {}
# variable "ecs_sg_ingress_rules" {}
# variable "ecs_sg_egress_rules" {}
# variable "task_cpu" {}  
# variable "task_memory" {}
# variable "ecs_launch_type" {}


variable "container_port" {}
variable "ecs_desired_count" {}
variable "alb_name" {}
/* variable "cert_arn" {} */
# variable "cluster_name" {} 
variable "container_name" {} 
variable "ecs_service_name" {}
# variable "container_definition_file" {}
variable "vpc_id" {}
variable "pub_subnet_ids" {}
variable "priv_subnet_ids" {}
variable "cluster_arn" {}
# variable "log_name" {}
# variable "cluster_count" {}
# variable "family_name" {}
variable "internal" {}
variable "image_name" {}
variable "task_environment_variables" {
  default = []
}
variable "env_value" {} 

/* variable "repository_name"{} */
