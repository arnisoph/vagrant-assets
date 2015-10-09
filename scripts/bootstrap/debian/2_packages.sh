#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -n "$MANAGE_SOURCES_LIST" ]]; then #TODO make it more configurable
cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian ${OS_CODENAME} main contrib non-free
deb-src http://ftp.debian.org/debian ${OS_CODENAME} main contrib non-free

deb http://security.debian.org/ ${OS_CODENAME}/updates main contrib non-free
deb-src http://security.debian.org/ ${OS_CODENAME}/updates main contrib non-free

deb http://ftp.debian.org/debian ${OS_CODENAME}-updates main contrib non-free
deb-src http://ftp.debian.org/debian ${OS_CODENAME}-updates main contrib non-free

deb http://ftp.debian.org/debian ${OS_CODENAME}-backports main contrib non-free
deb-src http://ftp.debian.org/debian ${OS_CODENAME}-backports main contrib non-free
EOF
fi

apt-get -q update
DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install apt-transport-https bind9-host wget

echo "Finishing ${0}.."
