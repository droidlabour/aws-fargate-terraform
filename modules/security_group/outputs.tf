output "fargate_security_group_id" {
  value = "${aws_security_group.fargate.id}"
}

output "alb_security_group_id" {
  value = "${aws_security_group.alb.id}"
}
