output "cloudfront_domain_name" { value = aws_cloudfront_distribution.s3_distribution.domain_name }
output "redis_endpoint" { value = aws_elasticache_cluster.redis.cache_nodes[0].address }