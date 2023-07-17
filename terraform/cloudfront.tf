data "aws_cloudfront_cache_policy" "cache_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "allviewer" {
  name = "Managed-AllViewer"
}

data "aws_acm_certificate" "cert" {
  domain = local.root_domain_name
  types  = ["AMAZON_ISSUED"]
}

module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  enabled = true
  aliases = [local.pack_domain_name]

  origin = {
    eb = {
      domain_name = aws_elastic_beanstalk_environment.packing_list.cname
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "eb"
    viewer_protocol_policy = "redirect-to-https"
    use_forwarded_values   = false
    cache_policy_id        = data.aws_cloudfront_cache_policy.cache_optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.allviewer.id

    allowed_methods = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  viewer_certificate = {
    acm_certificate_arn      = data.aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
