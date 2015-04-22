#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

wget -O /tmp/puppetlabs-release.deb https://apt.puppetlabs.com/puppetlabs-release-$(lsb_release -cs).deb
dpkg -i /tmp/puppetlabs-release.deb

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -yV install puppet

echo "Finishing ${0}.."
