#!/bin/bash

set -e

curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -

yum install -y nodejs sudo gcc-c++ make git openssl 

npm install -g node-gyp

cd /home
git clone https://github.com/key-networks/ztncui

cd /home/ztncui
git checkout develop

npm install

cp -v etc/default.passwd etc/passwd

cd etc/tls
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privkey.pem -out fullchain.pem -config /tmp/openssl.cnf

chown -R zerotier-one.zerotier-one /home/ztncui
