#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install apt-transport-https linux-headers-$(uname -r) bind9-host

# update package index on boot
cat <<EOF > /etc/init/refresh-apt.conf
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

echo "Finishing ${0}.."
