output "alb_dns_name" {
  value = module.networking.alb_dns_name
}

output "cloudfront_domain_name" {
  value = module.storage.cloudfront_domain_name
}

output "redis_endpoint" {
  value = module.storage.redis_endpoint
}