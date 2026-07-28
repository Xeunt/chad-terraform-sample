variable "aws_region" {
  description = "AWS region for the dev environment"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Base name for resources"
  type        = string
  default     = "chadsample"
}

variable "instance_type" {
  description = "EC2 instance type for the dev environment"
  type        = string
  default     = "t2.micro"
}
