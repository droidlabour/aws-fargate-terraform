variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}

variable "ecs_cluster_name" {
  default = "paranoid"
}

variable "alb_name" {
  default = "loki"
}

variable "route53_zone_id" {
  default = "Z3HGM7KWUR6XO6"
}

variable "domain_name" {
  default = "avengers.test.xyz"
}

variable "app_name_1" {
  default = "thor"
}

variable "app_name_2" {
  default = "thanos"
}

variable "app_name_3" {
  default = "hawkeye"
}

variable "app_name_4" {
  default = "tony"
}

variable "app_container_port_1" {
  default = "80"
}

variable "app_container_port_2" {
  default = "80"
}

variable "app_container_port_3" {
  default = "80"
}

variable "app_container_port_4" {
  default = "8080"
}

variable "app_path_1" {
  default = "/v1*"
}

variable "app_path_2" {
  default = "/v2*"
}

variable "app_path_3" {
  default = "/v3*"
}

variable "app_path_4" {
  default = "/v4*"
}

variable "ecr_1" {
  default = "142700881312.dkr.ecr.us-east-1.amazonaws.com/v1:latest"
}

variable "ecr_2" {
  default = "142700881312.dkr.ecr.us-east-1.amazonaws.com/v2:latest"
}

variable "ecr_3" {
  default = "tutum/hello-world:latest"
}

variable "ecr_4" {
  default = "mrbarker/python-flask-hello:latest"
}

variable "health_1" {
  default = "/"
}

variable "health_2" {
  default = "/"
}

variable "health_3" {
  default = "/"
}

variable "health_4" {
  default = "/"
}

variable "cpu_1" {
  default = "256"
}

variable "memory_1" {
  default = "512"
}

variable "cpu_2" {
  default = "256"
}

variable "memory_2" {
  default = "512"
}

variable "cpu_3" {
  default = "256"
}

variable "memory_3" {
  default = "512"
}

variable "cpu_4" {
  default = "256"
}

variable "memory_4" {
  default = "512"
}

variable "container_def_file_1" {
  default = "container_def_1.json"
}

variable "container_def_file_2" {
  default = "container_def_2.json"
}

variable "container_def_file_3" {
  default = "container_def_3.json"
}

variable "container_def_file_4" {
  default = "container_def_4.json"
}
