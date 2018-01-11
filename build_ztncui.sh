#!/bin/bash

set -e

touch /var/lib/zerotier-one/authtoken.secret
chown zerotier-one.zerotier-one /var/lib/zerotier-one/authtoken.secret
chmod 640 /var/lib/zerotier-one/authtoken.secret

yum install https://download.key-networks.com/el7/ztncui/1/ztncui-release-1-1.noarch.rpm -y
yum install ztncui -y
yum install sudo -y
rm -f /var/lib/zerotier-one/authtoken.secret
