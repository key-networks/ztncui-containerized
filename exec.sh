#!/bin/bash

/usr/sbin/zerotier-one &

while [ ! -f /var/lib/zerotier-one/authtoken.secret ]; do
  sleep 1
done
chmod g+r /var/lib/zerotier-one/authtoken.secret

cd /opt/key-networks/ztncui
exec sudo -u ztncui /opt/key-networks/ztncui/ztncui
