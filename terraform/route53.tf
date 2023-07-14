data "aws_route53_zone" "zone" {
  name = local.root_domain_name
}

resource "aws_route53_record" "pack" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.pack_domain_name
  type    = "A"
  alias {
    name                   = module.cdn.cloudfront_distribution_domain_name
    zone_id                = module.cdn.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}