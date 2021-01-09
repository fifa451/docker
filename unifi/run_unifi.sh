#!/bin/bash
if [ ! -f unifi_version ];then
    echo "Cannot find unifi version"
    exit 1
fi

. unifi_version

HOST_IP="192.168.1.202"
UNIFI_VERSION=${1:-$UNIFI_VERSION}

docker run -d \
        --network=unifi-vlan \
        --ip=${HOST_IP} \
        -p 8080:8080 \
        -p 8443:8443 \
        -p 3478:3478/udp   -p 10001:10001/udp \
        -e TZ='Australia/Brisbane'\
        -v /opt/unifi/data:/unifi \
        --name unifi unifi:${UNIFI_VERSION}
