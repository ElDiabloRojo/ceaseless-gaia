#!/bin/bash

WORKDIR=$TRAVIS_BUILD_DIR/environments/$1

cd $WORK_DIR
echo "Creating change plan"
terraform init $tf_init_cli_options
terraform validate $tf_validation_cli_options
