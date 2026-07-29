provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_s3_bucket" "dev_bucket" {
  bucket        = "${var.project_name}-dev-bucket-test11"#${data.aws_caller_identity.current.account_id}
  force_destroy = true

  tags = {
    Name        = "${var.project_name}-dev"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}