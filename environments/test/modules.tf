
module "ssl" {
  source = "../../modules/ssl"
  providers = {
    aws = aws.acm
  }
  domain_name     = local.domain_name
  route53_zone_id = local.route53_zone_id
}
