terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Note: Backend configuration for S3 would go here
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source   = "./modules/networking"
  vpc_cidr = var.vpc_cidr
}

module "compute" {
  source           = "./modules/compute"
  vpc_id           = module.networking.vpc_id
  public_subnets   = module.networking.public_subnets
  backend_sg_id    = module.networking.backend_sg_id
  target_group_arn = module.networking.alb_target_group_arn
  instance_type    = var.instance_type
}

module "storage" {
  source = "./modules/storage"
  vpc_id = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
}

module "monitoring" {
  source   = "./modules/monitoring"
  asg_name = module.compute.asg_name
}