variable "aws_region" {
  description = "AWS region for the dev environment"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Base name for resources"
  type        = string
  default     = "chad-sample-terraform"
}

variable "instance_type" {
  description = "EC2 instance type for the dev environment"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "chad-sample-terraform"
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

##--------------------




