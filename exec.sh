#!/bin/bash

HTTP_PORT=${HTTP_PORT:-3000}
HTTPS_PORT=${HTTPS_PORT:-3443}
HTTP_ALL_INTERFACES=${HTTP_ALL_INTERFACES:-no}

/usr/sbin/zerotier-one &

while [ ! -f /var/lib/zerotier-one/authtoken.secret ]; do
  sleep 1
done
chmod g+r /var/lib/zerotier-one/authtoken.secret

cd /opt/key-networks/ztncui

echo "HTTPS_PORT=$HTTPS_PORT" > /opt/key-networks/ztncui/.env
echo "HTTP_PORT=$HTTP_PORT" >> /opt/key-networks/ztncui/.env
echo "HTTP_ALL_INTERFACES=$HTTP_ALL_INTERFACES" >> /opt/key-networks/ztncui/.env

exec sudo -u ztncui /opt/key-networks/ztncui/ztncui
