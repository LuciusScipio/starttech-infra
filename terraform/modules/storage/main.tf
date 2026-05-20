resource "aws_s3_bucket" "frontend" {
  bucket_prefix = "starttech-frontend-"
}

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "S3-Frontend"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Frontend"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# 1. Group the network subnets together for your database cache
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "starttech-redis-subnet-group"
  subnet_ids = var.public_subnets
}

# 2. Spin up ElastiCache inside your defined subnet group
# Spin up ElastiCache inside your defined subnet group
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "starttech-redis"
  engine               = "redis"
  
  # CORRECTED: Changed from cache.t2.micro to cache.t3.micro
  node_type            = "cache.t3.micro" 
  
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
}