terraform {
  required_version = ">=0.13.0"
  backend "s3" {
    bucket         = "ceaseless-gaia-terraform-state"
    key            = "test/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "backend" {
  backend = "s3"
  config = {
    bucket = "ceaseless-gaia-terraform-state"
    key    = "backend/terraform.tfstate"
    region = "eu-central-1"
  }
}