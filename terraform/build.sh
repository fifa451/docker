#!/bin/bash

if [ ! -f terraform_version ];then
    echo "Cannot find terraform version"
    exit 1
fi
. terraform_version

TERRAFORM_VERSION=${1:-$TERRAFORM_VERSION}

USERNAME=$USER
USERID=$(id $USER -u)
GROUPID=$(id $USER -g)

docker build \
--build-arg TERRAFORM_VERSION=${TERRAFORM_VERSION} \
--build-arg USERNAME=${USERNAME} \
--build-arg USERID=${USERID} \
--build-arg GROUPID=${GROUPID} \
--rm -t terraform:$TERRAFORM_VERSION .

