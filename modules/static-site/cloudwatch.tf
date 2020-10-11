resource "aws_cloudwatch_metric_alarm" "website-healthcheck-alarm" {
  provider            = aws.acm
  alarm_name          = "${local.bucket_name}_alarm_healthcheck_failed"
  namespace           = "AWS/Route53"
  metric_name         = "HealthCheckStatus"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  period              =   "60"
  statistic           = "Minimum"
  threshold           = "1"
  unit                = "None"

  dimensions = {
    HealthCheckId = aws_route53_health_check.website-healthcheck.id
  }

  alarm_description  = "This metric monitors ${local.bucket_name} whether the service endpoint is down or not."
  treat_missing_data = "breaching"
}

resource "aws_route53_health_check" "website-healthcheck" {
  fqdn              = aws_route53_record.app.fqdn
  port              = 443
  type              = "HTTPS"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"
}