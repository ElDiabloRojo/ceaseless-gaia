locals {
  route53_domain = var.route53_domain != "" ? var.route53_domain : var.domain
}

resource "aws_route53_zone" "main" {
  name          = local.route53_domain
  force_destroy = true
}