variable "bucket_name" {
  type        = string
  description = "The Fully Qualified domain name should be the bucket name"
  default     = ""
}

variable "index_file_source" {
  type    = string
  default = "./src/index.html"
}

variable "error_file_source" {
  type    = string
  default = "./src/error.html"
}

# [TODO: consolidate zone related vars into one, they are the same.]
variable "route53_zone_id" {
  type = string
}

variable "route53_hosted_zone_id" {
  type = string
}

variable "domain" {
  type        = string
  description = "simple website where route53 hosted zone and bucket name are same. Naked domain"
  default     = ""
}

variable "s3_force_destroy" {
  type        = string
  description = "Destroy the s3 bucket inspite of contents in it."
  default     = "false"
}

variable "index_document" {
  type        = string
  description = "Index page to be used for website. Defaults to index.html"
  default     = "index.html"
}

variable "error_document" {
  type        = string
  description = "Error page to be used for website. Defaults to error.html"
  default     = "error.html"
}

variable "secret_user_agent" {
  type        = string
  description = "secret to authenticate CF requests to s3"
  default     = "SECRET-STRING"
}

variable "certificate_arn" {
  type = string
}