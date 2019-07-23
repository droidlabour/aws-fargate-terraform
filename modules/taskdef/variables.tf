variable "taskdef_name" {
  description = "Task definition Name"
}

variable "ecr_image" {
  description = "AWS ECR URI"
}

variable "container_port" {
  description = "Fargate container port"
}

variable "region" {
  description = "AWS region"
}

variable "cpu" {
  description = "vCPU"
}

variable "memory" {
  description = "Memory"
}

variable "container_def_file" {
  description = "Container definition filename"
}
