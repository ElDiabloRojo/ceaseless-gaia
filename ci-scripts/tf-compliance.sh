#!/bin/bash

set -x

terraform init $TF_SOURCE_DIR
terraform plan -out $TF_PLAN_FILE --var-file=$TF_SOURCE_DIR/terraform.tfvars $TF_SOURCE_DIR
docker run --rm -v $PWD:/target -it eerkunt/terraform-compliance -f tf-compliance -p $TF_PLAN_FILE