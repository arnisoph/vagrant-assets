#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

apt-get -q update
DEBIAN_FRONTEND=noninteractive apt-get -yV install lsb-release

if [[ -n "$MANAGE_SOURCES_LIST" ]]; then #TODO make it more configurable
cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian $(lsb_release -cs) main contrib non-free
deb-src http://ftp.debian.org/debian $(lsb_release -cs) main contrib non-free

deb http://security.debian.org/ $(lsb_release -cs)/updates main contrib non-free
deb-src http://security.debian.org/ $(lsb_release -cs)/updates main contrib non-free

deb http://ftp.debian.org/debian $(lsb_release -cs)-updates main contrib non-free
deb-src http://ftp.debian.org/debian $(lsb_release -cs)-updates main contrib non-free

deb http://ftp.debian.org/debian $(lsb_release -cs)-backports main contrib non-free
deb-src http://ftp.debian.org/debian $(lsb_release -cs)-backports main contrib non-free
EOF
fi

apt-get -q update
DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install apt-transport-https bind9-host wget apt-utils curl net-tools

echo "Finishing ${0}.."
