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
  default = "142700881312.dkr.ecr.us-east-1.amazonaws.com/v3:latest"
}

variable "ecr_4" {
  default = "142700881312.dkr.ecr.us-east-1.amazonaws.com/v4:latest"
}
