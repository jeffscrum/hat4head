# IPSet blocklist tools

## Description
Scripts allow you to block server connections (including app in Docker) by ipset.  
To regularly update ipset lists, run the `update.sh` by cron.

## Installation
1. Copy *.sh files to `/etc/ipset/` and make them executable
2. Copy *.service files to `/etc/systemd/system/`
3. Run `systemctl daemon-reload`
4. Run `systemctl enable ipset-persistent.service` and `systemctl enable ipset-docker-rules.service`
