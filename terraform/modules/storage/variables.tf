variable "vpc_id" {
  type        = string
  description = "The ID of the custom VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet IDs to place the Redis cluster into"
}