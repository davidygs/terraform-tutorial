# Define SSH key pair for our instances
resource "aws_key_pair" "test-kp" {
  key_name   = "test-kp"
  public_key = "${file("${var.key_path}")}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Launch an instance in the public subnet
resource "aws_instance" "public_ec2" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.test-kp.id}"
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.test-sg.id}"]
  associate_public_ip_address = true
  #source_dest_check = false

  tags = {
    Name = "public instance"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.test-kp.id}"
  subnet_id              = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.test-sg.id}"]
  # source_dest_check = false

  tags = {
    Name = "private instance"
  }
}
