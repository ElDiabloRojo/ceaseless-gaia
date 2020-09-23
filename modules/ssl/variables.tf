
variable "domain_name" {
  type        = string
  description = "AWS Profile to choose"
  default     = "default"
}

variable "route53_zone_id" {
  type = string
}