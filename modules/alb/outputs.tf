output "dns_url" {
  value = "${aws_lb.alb.dns_name}"
}

output "zone_id" {
  value = "${aws_lb.alb.zone_id}"
}

output "listener_arn" {
  value = "${aws_lb_listener.app_gatwy.arn}"
}
