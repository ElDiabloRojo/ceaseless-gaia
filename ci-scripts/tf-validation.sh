#!/bin/bash

set -x

echo $TRAVIS_BUILD_DIR

echo $1

WORKDIR=$TRAVIS_BUILD_DIR/environments/$1

cd $WORKDIR
echo "Creating change plan"
terraform init $tf_init_cli_options
terraform validate $tf_validation_cli_options
