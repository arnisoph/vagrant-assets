#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y install tree vim bash-completion apt-transport-https bind9-host

echo "Finishing ${0}.."
