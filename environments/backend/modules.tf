
module "remote-state" {
  source               = "../../modules/remote-state"
  name_of_s3_bucket    = "ceaseless-gaia-terraform-state"
  dynamo_db_table_name = "aws-locks"
}

module "hosted-zone" {
  source         = "../../modules/hosted-zone"
  route53_domain = "phytology.co.uk"
}
