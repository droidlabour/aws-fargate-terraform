output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_1_id" {
  value = "${aws_subnet.vpc-public-1.id}"
}

output "public_subnet_2_id" {
  value = "${aws_subnet.vpc-public-2.id}"
}

output "private_subnet_1_id" {
  value = "${aws_subnet.vpc-private-1.id}"
}

output "private_subnet_2_id" {
  value = "${aws_subnet.vpc-private-2.id}"
}
