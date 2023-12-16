provider "aws" {
  region  = "us-east-1"
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

resource "aws_instance"  "Madan-VM"{
  ami                   = data.aws_ami.latest-ubuntu.id
  instance_type         = "t2.micro"
#  count                 = 2
  key_name      = "ubuntu"
  tags = {
        "Name"                          = "Madan-VM"
  }
  subnet_id                     = "subnet-03f3581fbfa402f20"
  associate_public_ip_address = "true"
  vpc_security_group_ids        = ["sg-057d8f19e0747e018"]
  root_block_device {
        volume_size = 8
        volume_type = "gp2"
  }
}