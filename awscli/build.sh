#!/bin/bash

if [ ! -f awscli_version ];then
    echo "Cannot fild awscli_version"
    exit 1
fi

. awscli_version
AWSCLI_VERSION=${1:-1.15.36}

docker build\
    --build-arg AWSCLI_VERSION=${AWSCLI_VERSION} \
    -t awscli:${AWSCLI_VERSION} .
