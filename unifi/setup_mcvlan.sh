#!/bin/bash

if [ ! -z $1 ]
then
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  --ip-range=192.168.1.192/27 \
  -o parent=enp4s0 \
  --aux-address 'host=192.168.1.223' \
 unifi-vlan 
fi


## add  bridge to my 192.168.1.223
sudo ip link add unifi-bridge link enp4s0 type macvlan  mode bridge
## Add address
sudo ip addr add 192.168.1.223/32 dev unifi-bridge
## bring it run
sudo ip link set unifi-bridge up
## routes
sudo ip route add  192.168.1.192/27 dev unifi-bridge

