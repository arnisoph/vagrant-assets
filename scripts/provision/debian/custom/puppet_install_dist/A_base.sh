#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -z "$(which puppet)" ]]; then
  wget -O /tmp/puppetlabs-release.deb https://apt.puppetlabs.com/puppetlabs-release-$(lsb_release -cs).deb
  dpkg -i /tmp/puppetlabs-release.deb

  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get -yV install puppet
fi

echo "Finishing ${0}.."
