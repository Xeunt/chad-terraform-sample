provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "dev_bucket" {
  bucket        = "${var.project_name}-dev-bucket-${data.aws_caller_identity.current.account_id}"
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