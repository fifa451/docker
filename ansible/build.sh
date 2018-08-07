#!/bin/bash
if [ ! -f ansible_version ];then
	echo "Cannot file files"
	exit 1
fi

. ansible_version
echo $ANSIBLE_VERSION
# ANSIBLE_VERSION=${}
docker build\
	--build-arg ANSIBLE_VERSION=${ANSIBLE_VERSION} \
	--rm -t ansible:${ANSIBLE_VERSION} .
