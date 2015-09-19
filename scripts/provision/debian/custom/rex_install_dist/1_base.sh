#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

echo "deb https://rex.linux-files.org/debian/ $(lsb_release -cs) rex" > /etc/apt/sources.list.d/rex.list
wget -O - https://rex.linux-files.org/DPKG-GPG-KEY-REXIFY-REPO | apt-key add -
apt-get -q update

DEBIAN_FRONTEND=noninteractive apt-get -yV install rex

echo "Finishing ${0}.."
