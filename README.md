# terraform-tutorial
A simple Terraform tutorial to create two subnets and two ec2 instances

# What is it?
Just a simple tutorial to help me understand basic concepts of Terraform.

This project creates an AWS VPC with two subnets, one public and one private. Each subnet will have a Ubuntu instance running, accepting *PING* and *SSH*.

# How to run the tutorial?

## Setup
```
$ aws configure
$ export TF_VAR_aws_region=[your region]
$ export TF_VAR_aws_az_1=[az for public subnet]
$ export TF_VAR_aws_az_2=[az for private subnet]
$ ssh-keygen -f ~/.ssh/test
$ export TF_VAR_key_path=~/.ssh/test.pub
```

## Create cluster
```
$ terraform init
$ terraform apply
```

## Verify cluster
```
$ ping [public_ec2_public_ip]
$ ssh -i ~/.ssh/test ubuntu@[public_ec2_public_ip]
```

## Cleanup
```
$ terraform destroy
```
