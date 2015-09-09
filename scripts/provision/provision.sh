#!/bin/bash

provisioner=$1
[[ -z "$provisioner" ]] && provisioner=helloworld

echo "Sourcing scripts that set environment variables for provision scripts.."
[[ -r "/tmp/vagrant-provision-${provisioner}-env.sh" ]] && source "/tmp/vagrant-provision-${provisioner}-env.sh"

echo "Making all shell scripts executable.."
find /vagrant/scripts/ -type f -name '*.sh' -exec chmod +x {} \;
[[ -d /vagrant/shared/misc/scripts/$(hostname -s)/ ]] && find /vagrant/shared/misc/scripts/$(hostname -s)/ -type f -name '*.sh' -exec chmod +x {} \;

echo "Executing shell scripts.."

export PATH=${PATH}:/usr/local/bin/

if [[ -e "/vagrant/shared/misc/scripts/$(hostname -s)/${provisioner}-pre.sh" ]]; then
  /vagrant/shared/misc/scripts/$(hostname -s)/${provisioner}-pre.sh || exit 1
fi

if [[ -d "/vagrant/scripts/custom/${provisioner}" ]]; then
  for f in $(ls -r /vagrant/scripts/custom/${provisioner}/*.sh | sort); do
    ${f} || exit 1
  done
else
  for f in /vagrant/scripts/${provisioner}/*.sh; do
    ${f} || exit 1
  done
fi

if [[ -e "/vagrant/shared/misc/scripts/$(hostname -s)/${provisioner}-post.sh" ]]; then
  /vagrant/shared/misc/scripts/$(hostname -s)/${provisioner}-post.sh || exit 1
fi

echo "Finishing ${0}.."
