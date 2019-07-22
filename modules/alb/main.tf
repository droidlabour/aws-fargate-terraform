resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  security_groups    = [var.security_groups]
  load_balancer_type = "application"
  subnets = [
    var.subnet_1_id,
    var.subnet_2_id
  ]
}


resource "aws_lb_listener" "app_gatwy" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Request didn't match with any listener rules."
      status_code  = "200"
    }
  }
}
