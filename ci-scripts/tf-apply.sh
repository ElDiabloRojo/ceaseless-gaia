#!/bin/bash

#
# This script is used to run the terraform apply subcommand, and will deploy 
# a given environments IaC source.
#

set -x

# [TODO: move path of workdir out of this script, we only want an input param]

WORK_DIR=$TRAVIS_BUILD_DIR/environments/$1