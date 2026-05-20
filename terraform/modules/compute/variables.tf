variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "backend_sg_id" {
  type        = string
  description = "Security group ID for the backend EC2 instances"
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the ALB target group"
}

variable "instance_type" {
  type        = string
  description = "Free Tier eligible EC2 instance type"
  default     = "t2.micro" # Strictly force t2.micro for Free Tier stability
}