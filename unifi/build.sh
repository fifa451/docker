#!/bin/bash

if [ ! -f unifi_version ];then
	    echo "Cannot find unifi version"
	        exit 1
fi
. unifi_version

	UNIFI_VERSION=${1:-$UNIFI_VERSION}

	USERNAME=$USER
	USERID=$(id $USER -u)
	GROUPID=$(id $USER -g)

docker pull jacobalberty/unifi:arm32v7-beta
docker tag jacobalberty/unifi:arm32v7-beta unifi:${UNIFI_VERSION}
#docker build \
#	--build-arg UNIFI_VERSION=${UNIFI_VERSION} \
#	--rm -t unifi:$UNIFI_VERSION .
