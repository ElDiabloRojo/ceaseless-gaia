#!/bin/bash

set -x

terraform init $TF_SOURCE_DIR
terraform plan $TF_SOURCE_DIR -out $TF_PLAN_FILE
docker run --rm -v $PWD:/target -it eerkunt/terraform-compliance -f tf-compliance -p $TF_PLAN_FILE