#!/bin/bash

ipsetname=blocked-ip

if [[ -z `iptables -L INPUT | grep "match-set $ipsetname src"` ]];
then
    iptables -I INPUT -m set --match-set $ipsetname src -j DROP
fi
if [[ -z `iptables -L DOCKER-USER | grep "match-set $ipsetname src"` ]];
then
    iptables -I DOCKER-USER -m set --match-set $ipsetname src -j DROP
fi
