#!/bin/bash
# Derived from script from https://install.zerotier.com

set -ex

<<ENDOFSIGSTART=
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ENDOFSIGSTART=

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin

#
# ZeroTier install script
#
# All this script does is determine your OS and/or distribution and then add the correct
# repository or download the correct package and install it. It then starts the service
# and prints your device's ZeroTier address.
#

# Base URL for download.zerotier.com tree; see https://github.com/zerotier/download.zerotier.com if you want to mirror.
# Some things want http, some https, so we must specify both. Must include trailing /
ZT_BASE_URL_HTTPS='https://download.zerotier.com/'
ZT_BASE_URL_HTTP='http://download.zerotier.com/'

# Detect already-installed on Linux
if [ -f /usr/sbin/zerotier-one ]; then
	echo '*** ZeroTier One appears to already be installed.'
	exit 0
fi

rm -f /tmp/zt-gpg-key
echo '-----BEGIN PGP PUBLIC KEY BLOCK-----' >/tmp/zt-gpg-key
cat >>/tmp/zt-gpg-key << END_OF_KEY
Comment: GPGTools - https://gpgtools.org

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
=JgAv
END_OF_KEY
echo '-----END PGP PUBLIC KEY BLOCK-----' >>/tmp/zt-gpg-key

echo '*** Detecting Linux Distribution'
echo

baseurl="${ZT_BASE_URL_HTTP}redhat/el/7"

rpm --import /tmp/zt-gpg-key

rm -f /tmp/zerotier.repo
echo '[zerotier]' >/tmp/zerotier.repo
echo 'name=ZeroTier, Inc. RPM Release Repository' >>/tmp/zerotier.repo
echo "baseurl=$baseurl" >>/tmp/zerotier.repo
echo 'enabled=1' >>/tmp/zerotier.repo
echo 'gpgcheck=1' >>/tmp/zerotier.repo

mv -f /tmp/zerotier.repo /etc/yum.repos.d/zerotier.repo
chown 0 /etc/yum.repos.d/zerotier.repo
chgrp 0 /etc/yum.repos.d/zerotier.repo

# Avoid uid and gid conflicts in Ubuntu Docker hosts
groupadd -g 2000 zerotier-one
useradd -u 2000 -g 2000 zerotier-one
groupadd -g 2001 ztncui
useradd -u 2001 -g 2001 ztncui

echo
echo '*** Installing zerotier-one package...'

dnf install -y zerotier-one

rm -f /tmp/zt-gpg-key

if [ ! -e /usr/sbin/zerotier-one ]; then
	echo
	echo '*** Package installation failed! Unfortunately there may not be a package'
	echo '*** for your architecture or distribution. For the source go to:'
	echo '*** https://github.com/zerotier/ZeroTierOne'
	echo
	exit 1
else
  echo '*** ZeroTier One is installed ***'
fi

touch /var/lib/zerotier-one/authtoken.secret
chown zerotier-one.zerotier-one /var/lib/zerotier-one/authtoken.secret
chmod 640 /var/lib/zerotier-one/authtoken.secret

dnf install https://download.key-networks.com/el7/ztncui/1/ztncui-release-1-1.noarch.rpm -y
dnf install ztncui -y
dnf install sudo -y

rm -f /var/lib/zerotier-one/authtoken.secret
echo 'HTTPS_PORT=3443' > /opt/key-networks/ztncui/.env
