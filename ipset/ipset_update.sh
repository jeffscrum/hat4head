#!/bin/bash

# Create new iphash table, if not exist
ipset create -exist blacklist iphash

# Create new iphash table
ipset create blacklist_tmp iphash

# Download address list
wget -O /tmp/blacklist_sw.lst https://raw.githubusercontent.com/jeffscrum/hat4head/master/ipset/blacklist.lst

echo -n "Fill ipset..."
# Read file and add to ipset table
list=$(cat /tmp/blacklist_sw.lst)
for addr in $list
  do
    ipset -A blacklist_tmp $addr
  done
echo "Done"

# Swap old tables with tmp
ipset swap blacklist blacklist_tmp

# Destroy tmp table
ipset destroy blacklist_tmp

# Cleanup
rm -f /tmp/blacklist_sw.lst
