#!/bin/bash

## Dependency:
# - wget
# - ipset
# - iprange

# Create new nethash set, if not exist
ipset create -exist blocked-ip hash:net family inet hashsize ${HASHSIZE:-16384} maxelem ${MAXELEM:-65536}

# Create new temporary nethash set, if not exist
ipset create -exist blocked-ip-tmp hash:net family inet hashsize ${HASHSIZE:-16384} maxelem ${MAXELEM:-65536}

# Download net list
wget -O /etc/ipset/blocked-ip.lst.tmp https://raw.githubusercontent.com/jeffscrum/hat4head/master/ipset/blocked-ip.lst

# Optimize list
iprange --optimize --print-suffix-ips "/32" /etc/ipset/blocked-ip.lst.tmp > /etc/ipset/blocked-ip.lst

# Read file and add to ipset
list=$(cat /etc/ipset/blocked-ip.lst)
for addr in $list
  do
    ipset -A blocked-ip-tmp $addr
  done

# Swap 'blocked-ip' table and 'blocked-ip_tmp'
ipset swap blocked-ip blocked-ip-tmp

# Destroy tmp table
ipset flush blocked-ip-tmp

# Cleanup
#rm -f /etc/ipset/blocked-ip.lst.tmp

# Create log entry
logger "IPset updated"
