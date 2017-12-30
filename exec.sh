#!/bin/bash

/usr/sbin/zerotier-one &
sleep 1
chown -R zerotier-one.zerotier-one /var/lib/zerotier-one

cd /home/ztncui
exec sudo -u zerotier-one npm start
