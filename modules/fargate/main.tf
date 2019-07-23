resource "aws_lb_target_group" "app" {
  name                 = var.target_group_name
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = 0
  health_check {
    enabled             = true
    interval            = 30
    path                = var.health
    protocol            = "HTTP"
    timeout             = "10"
    matcher             = "200,202,301"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
  }
}


resource "aws_lb_listener_rule" "app_rule" {
  listener_arn = var.listener_arn
  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.app.arn}"
  }
  condition {
    field  = "path-pattern"
    values = [var.app_path]
  }
}


resource "aws_ecs_service" "app" {
  name            = var.fargate_service_name
  cluster         = var.ecs_cluster_id
  task_definition = var.task_definition
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups = [var.security_group_id]
    subnets = [
      var.subnet_1_id,
      var.subnet_2_id
    ]
  }
  load_balancer {
    target_group_arn = "${aws_lb_target_group.app.arn}"
    container_name   = var.container_name
    container_port   = var.container_port
  }
  depends_on = [aws_lb_target_group.app, aws_lb_listener_rule.app_rule]
}
