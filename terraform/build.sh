#!/bin/bash

if [ ! -f terraform_version ];then
    echo "Cannot find terraform version"
    exit 1
fi
. terraform_version

TERRAFORM_VERSION=${1:-0.11.7}


docker build\
--build-arg TERRAFORM_VERSION=${TERRAFORM_VERSION} \
--rm -t terraform:$TERRAFORM_VERSION .