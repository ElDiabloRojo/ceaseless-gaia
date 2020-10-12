#!/bin/bash

#
# This script is used to run the terraform validation subcommand against a 
# given environments IaC directory. Validate contributes to static analysis and
# ensures the terraform code is syntactically correct.
#

set -x

# [TODO: move path of workdir out of this script, we only want an input param]

WORK_DIR=$TRAVIS_BUILD_DIR/environments/$1

cd "$WORK_DIR" || { echo "Error: terraform environment not found"; exit 1; }
echo "Creating change plan"
terraform init "$tf_init_cli_options"
terraform validate "$tf_validation_cli_options"
