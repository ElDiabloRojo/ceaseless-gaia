terraform {
  required_version = ">=0.13.0"
  backend "local" { }
}

provider "aws" {
  alias   = "acm"
  region  = "us-east-1"
  version = "~> 2.60.0"
}

provider "aws" {
  region  = "eu-central-1"
  version = "~> 2.60.0"
}

module "website" {
  source           = "../../../modules/website"
  domain           = "phytology.co.uk"
  bucket_name      = "test"
  s3_force_destroy = true
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile to choose"
  default     = "default"
}

output "route53_app_fqdn" {
  value = module.website.route53_app_fqdn
}