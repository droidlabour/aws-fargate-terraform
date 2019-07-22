resource "aws_security_group" "alb" {
  vpc_id = var.vpc_id
}


resource "aws_security_group_rule" "alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb.id}"
}


resource "aws_security_group_rule" "alb_outbnd" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb.id}"
}


resource "aws_security_group" "fargate" {
  vpc_id = var.vpc_id
}


resource "aws_security_group_rule" "fargate_http" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.fargate.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
}


resource "aws_security_group_rule" "fargate_outbnd" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fargate.id}"
}
