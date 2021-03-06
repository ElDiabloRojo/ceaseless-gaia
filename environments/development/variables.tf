
variable "aws_profile" {
  type        = string
  description = "AWS Profile to choose"
  default     = "default"
}

variable "environment" {}
variable "domain" {}

locals {
  domain_name     = "${var.environment}.${var.domain}"
  route53_zone_id = data.terraform_remote_state.backend.outputs.route53_zone_id
}