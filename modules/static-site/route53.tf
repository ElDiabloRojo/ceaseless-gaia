resource "aws_route53_record" "app" {
  zone_id = var.route53_hosted_zone_id
  name    = local.bucket_name
  type    = "CNAME"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
