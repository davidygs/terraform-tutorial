# Define our VPC
resource "aws_vpc" "test-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "test-vpc"
  }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id            = "${aws_vpc.test-vpc.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${var.aws_az_1}"

  tags = {
    Name = "Public Subnet"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = "${aws_vpc.test-vpc.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.aws_az_2}"

  tags = {
    Name = "Private Subnet"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.test-vpc.id}"

  tags = {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.test-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Public Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

# Define the security group for both subnets
# This is associated with each instance (instead of each subnet)
resource "aws_security_group" "test-sg" {
  name        = "test-sg"
  description = "Allow incoming SSH access and PING"

  ingress {
    from_port   = 8
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # This is required
  # Refer to https://www.terraform.io/docs/providers/aws/r/security_group.html#description-2
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.test-vpc.id}"

  tags = {
    Name = "Test SG"
  }
}
