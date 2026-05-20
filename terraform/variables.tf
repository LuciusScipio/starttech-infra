variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type for backend"
  default     = "t2.micro"
}