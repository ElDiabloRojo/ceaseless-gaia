#!/bin/bash

set -x

cd $TF_SOURCE_DIR

terraform init
terraform plan -out $TF_PLAN_FILE

terraform-compliance --features features --planfile $TF_PLAN_FILE