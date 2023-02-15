# variable "cluster_name" {} 
# variable "container_name" {} 
# variable "ecs_service_name" {} 
# variable "container_definition_file" {} 

variable "containers" {
  type = map
  default = {}
}
variable "aws_region" {
}

variable "cluster_name" {}
variable "publicly_accessible"{}
variable "file_handler" {}
variable "function_name" {}

variable "memory_size" {}
variable "runtime" {}
variable "lambda_bucket" {}

variable "load_balancer_name" {}
variable "target_group_name" {}
variable "timeout" {}



/* variable "repository_name"{} */
variable "envs" {
  
}