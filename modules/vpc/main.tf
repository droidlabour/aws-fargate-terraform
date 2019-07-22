data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_classiclink   = "false"
  enable_dns_hostnames = "true"
}


resource "aws_subnet" "vpc-public-1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
}


resource "aws_subnet" "vpc-public-2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "true"
}


resource "aws_subnet" "vpc-private-1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "false"
}


resource "aws_subnet" "vpc-private-2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"
}


resource "aws_internet_gateway" "vpc-gw" {
  vpc_id = "${aws_vpc.vpc.id}"
}


resource "aws_route_table" "vpc-public" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-gw.id}"
  }
}


resource "aws_route_table_association" "vpc-public-1-a" {
  subnet_id      = "${aws_subnet.vpc-public-1.id}"
  route_table_id = "${aws_route_table.vpc-public.id}"
}


resource "aws_route_table_association" "vpc-public-2-a" {
  subnet_id      = "${aws_subnet.vpc-public-2.id}"
  route_table_id = "${aws_route_table.vpc-public.id}"
}


resource "aws_eip" "vpc-nat" {
  vpc = true
}


resource "aws_nat_gateway" "vpc-nat-gw" {
  subnet_id     = "${aws_subnet.vpc-public-1.id}"
  depends_on    = ["aws_internet_gateway.vpc-gw"]
  allocation_id = "${aws_eip.vpc-nat.id}"
}


resource "aws_route_table" "vpc-private" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.vpc-nat-gw.id}"
  }
}


resource "aws_route_table_association" "vpc-private-1-a" {
  subnet_id      = "${aws_subnet.vpc-private-1.id}"
  route_table_id = "${aws_route_table.vpc-private.id}"
}


resource "aws_route_table_association" "vpc-private-2-a" {
  subnet_id      = "${aws_subnet.vpc-private-2.id}"
  route_table_id = "${aws_route_table.vpc-private.id}"
}
