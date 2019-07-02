variable "aws_region" {
  description = "Region for VPC"
  default     = "ap-northeast-1"
}

variable "aws_az_1" {
  description = "Availability zone 1"
  default     = "ap-northeast-1a"
}

variable "aws_az_2" {
  description = "Availability zone 2"
  default     = "ap-northeast-1c"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default     = "10.0.2.0/24"
}

variable "key_path" {
  description = "SSH Public Key path"
}
