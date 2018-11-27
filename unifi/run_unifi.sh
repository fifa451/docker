#!/bin/sh
docker run \
        --network=unifi-vlan \
        --rm \
        --init \
        -p 8080:8080 \
        -p 8443:8443 \
        -p 3478:3478/udp   -p 10001:10001/udp \
        -e TZ='Australia/Brisbane'\
        -v ~/work/unifi/unifi:/unifi \
        --name unifi jacobalberty/unifi:stable

