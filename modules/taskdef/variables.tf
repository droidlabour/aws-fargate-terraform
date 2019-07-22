variable "taskdef_name" {
  description = "Task definition Name"
}

variable "ecr_image" {
  description = "AWS ECR URI"
}

variable "container_port" {
  description = "Fargate container port"
}
