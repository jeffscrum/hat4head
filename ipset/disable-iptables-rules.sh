#!/bin/bash

ipsetname=blocked-ip

if [[ -n `iptables -L INPUT | grep "match-set $ipsetname src"` ]];
then
    iptables -D INPUT -m set --match-set $ipsetname src -j DROP
fi
if [[ -n `iptables -L DOCKER-USER | grep "match-set $ipsetname src"` ]];
then
    iptables -D DOCKER-USER -m set --match-set $ipsetname src -j DROP
fi
