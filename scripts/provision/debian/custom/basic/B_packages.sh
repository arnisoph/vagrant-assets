#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install tree vim bash-completion apt-transport-https bind9-host

echo "Finishing ${0}.."
