provider "aws" {
  profile = var.profile
  region  = var.region
}


module "vpc" {
  source = "./modules/vpc"
}


module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}


resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}


module "alb" {
  source          = "./modules/alb"
  alb_name        = var.alb_name
  subnet_1_id     = module.vpc.public_subnet_1_id
  subnet_2_id     = module.vpc.public_subnet_2_id
  security_groups = module.security_group.alb_security_group_id
}


module "taskdef_1" {
  source       = "./modules/taskdef"
  ecr_image    = var.ecr_1
  taskdef_name = var.app_name_1
}


module "taskdef_2" {
  source       = "./modules/taskdef"
  ecr_image    = var.ecr_2
  taskdef_name = var.app_name_2
}


module "taskdef_3" {
  source       = "./modules/taskdef"
  ecr_image    = var.ecr_3
  taskdef_name = var.app_name_3
}


module "taskdef_4" {
  source       = "./modules/taskdef"
  ecr_image    = var.ecr_4
  taskdef_name = var.app_name_4
}


module "app_1" {
  source               = "./modules/fargate"
  vpc_id               = module.vpc.vpc_id
  app_path             = var.app_path_1
  listener_arn         = module.alb.listener_arn
  subnet_1_id          = module.vpc.private_subnet_1_id
  subnet_2_id          = module.vpc.private_subnet_2_id
  container_name       = var.app_name_1
  container_port       = 80
  ecs_cluster_id       = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition      = module.taskdef_1.arn
  target_group_name    = var.app_name_1
  security_group_id    = module.security_group.fargate_security_group_id
  fargate_service_name = var.app_name_1
}


module "app_2" {
  source               = "./modules/fargate"
  vpc_id               = module.vpc.vpc_id
  app_path             = var.app_path_2
  listener_arn         = module.alb.listener_arn
  subnet_1_id          = module.vpc.private_subnet_1_id
  subnet_2_id          = module.vpc.private_subnet_2_id
  container_name       = var.app_name_2
  container_port       = 80
  ecs_cluster_id       = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition      = module.taskdef_2.arn
  target_group_name    = var.app_name_2
  security_group_id    = module.security_group.fargate_security_group_id
  fargate_service_name = var.app_name_2
}


module "app_3" {
  source               = "./modules/fargate"
  vpc_id               = module.vpc.vpc_id
  app_path             = var.app_path_3
  listener_arn         = module.alb.listener_arn
  subnet_1_id          = module.vpc.private_subnet_1_id
  subnet_2_id          = module.vpc.private_subnet_2_id
  container_name       = var.app_name_3
  container_port       = 80
  ecs_cluster_id       = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition      = module.taskdef_3.arn
  target_group_name    = var.app_name_3
  security_group_id    = module.security_group.fargate_security_group_id
  fargate_service_name = var.app_name_3
}


module "app_4" {
  source               = "./modules/fargate"
  vpc_id               = module.vpc.vpc_id
  app_path             = var.app_path_4
  listener_arn         = module.alb.listener_arn
  subnet_1_id          = module.vpc.private_subnet_1_id
  subnet_2_id          = module.vpc.private_subnet_2_id
  container_name       = var.app_name_4
  container_port       = 80
  ecs_cluster_id       = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition      = module.taskdef_4.arn
  target_group_name    = var.app_name_4
  security_group_id    = module.security_group.fargate_security_group_id
  fargate_service_name = var.app_name_4
}


resource "aws_route53_record" "a_record" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = module.alb.dns_url
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}


output "vpc_id" {
  value = module.vpc.vpc_id
}


output "alb_dns_url" {
  value = module.alb.dns_url
}
