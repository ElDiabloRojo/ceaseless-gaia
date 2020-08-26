resource "aws_acm_certificate" "cert" {
  provider  = aws.acm
  domain_name       = local.bucket_name
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "cert" {
  provider  = aws.acm
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
