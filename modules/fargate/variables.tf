variable "fargate_service_name" {
  description = "Fargate service name"
}

variable "task_definition" {
  description = "Task definition AWS ARN"
}

variable "security_group_id" {
  description = "Security group ID used by Fargate"
}

variable "subnet_1_id" {
  description = "Subnet ID 1 used by Fargate"
}

variable "subnet_2_id" {
  description = "Subnet ID 2 used by Fargate"
}

variable "ecs_cluster_id" {
  description = "ECS cluster ID"
}

variable "container_name" {
  description = "Container name as it appears in a container definition"
}

variable "container_port" {
  description = "Container port to associate with the load balancer"
}

variable "target_group_name" {
  description = "Target group name"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "listener_arn" {
  description = "ALB listener AWS ARN"
}

variable "app_path" {
  description = "Unique path for each app"
}
