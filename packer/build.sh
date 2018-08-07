#!/bin/bash

if [ ! -f packer_version ];then
    echo "Cannot find packer version file" 
    exit 1
fi

. packer_version

PACKER_VERSION=${1:-1.2.4}

docker build\
	 --build-arg PACKER_VERSION=${PACKER_VERSION}\
	 --rm -t packer:$PACKER_VERSION .
