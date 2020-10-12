
module "static-site" {
  source                 = "../../modules/static-site"
  bucket_name            = "dev.phytology.co.uk"
  route53_zone_id        = local.route53_zone_id
  route53_hosted_zone_id = local.route53_zone_id
  s3_force_destroy       = true
  certificate_arn        = module.ssl.certificate_arn
}

module "ssl" {
  source = "../../modules/ssl"
  providers = {
    aws = aws.acm
  }
  domain_name     = local.domain_name
  route53_zone_id = local.route53_zone_id
}