# Require TF version to be same as or greater than 0.12.19
terraform {
  required_version = ">=0.13.0"
  backend "s3" {
    bucket         = "ceaseless-gaia-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

# Download AWS provider
provider "aws" {
  region  = "eu-central-1"
  version = "~> 2.60.0"
}

# Call the seed_module to build our ADO seed info
module "backend" {
  source                      = "./modules/backend"
  name_of_s3_bucket           = "ceaseless-gaia-terraform-state"
  dynamo_db_table_name        = "aws-locks"
}

# Simple website serving at naked domain / www. subdomain
module "website" {
  source  = "./modules/s3-website"
  domain  = "phytology.co.uk"
}

# AWS Specific variables
variable "aws_region" {
  type        = string
  description = "AWS Region to create the resource"
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile to choose"
  default     = "default"
}