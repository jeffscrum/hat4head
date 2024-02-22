#!/bin/bash

# Create new nethash set, if not exist
ipset create -exist blacklist nethash

# Create new nethash set
ipset create blacklist_tmp nethash

# Download net list
wget -O /tmp/blacklist_tmp.lst https://raw.githubusercontent.com/jeffscrum/hat4head/master/ipset/blacklist.lst

echo -n "Fill ipset..."
# Read file and add to ipset
list=$(cat /tmp/blacklist_tmp.lst)
for addr in $list
  do
    ipset -A blacklist_tmp $addr
  done
echo "Done"

# Swap 'blacklist' table and 'blacklist_tmp'
ipset swap blacklist blacklist_tmp

# Destroy tmp table
ipset destroy blacklist_tmp

# Cleanup
rm -f /tmp/blacklist_tmp.lst
