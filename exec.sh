#!/bin/bash

/usr/sbin/zerotier-one &

cd /home/ztncui
exec sudo -u zerotier-one npm start
