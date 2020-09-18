output "route53_zone_id" {
  value = aws_route53_zone.main.id
}

output "route53_hosted_zone_id" {
  value = aws_route53_zone.main.zone_id
}