provider "aws" {
  region  = "${var.region}"
#  profile = "aws"
}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners        = ["099720109477"] # Canonical

  filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
        name   = "virtualization-type"
        values = ["hvm"]
  }
}

resource "aws_instance"  "Devops_Demo"{
  ami                   = data.aws_ami.latest-ubuntu.id
  instance_type         = "${var.instance_type}"
  key_name      = "ubuntu"
  tags = {
        "Name"                          = "${var.instance_name}"
  }
  subnet_id                     = "${var.subnet_id}"
  associate_public_ip_address = "true"
  vpc_security_group_ids        = ["sg-057d8f19e0747e018"]
  root_block_device {
        volume_size = 8
        volume_type = "gp2"
  }
}



+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
######## variable.tf #############

variable "region" {
  default = "us-east-1"

}

variable "instance_name" {
  type = string
  default = "Devops_Demo"

}


variable "instance_type" {
  default = "t2.micro"

}

variable "subnet_id" {
  default = "subnet-03f3581fbfa402f20"

}

