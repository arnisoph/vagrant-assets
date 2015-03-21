#!/bin/bash

provisioner=$1
[[ -z "$provisioner" ]] && provisioner=helloworld

echo "Making all shell scripts executable.."
find /vagrant/scripts/ -type f -name '*.sh' -exec chmod +x {} \;

echo "Executing shell scripts.."
if [[ -d "/vagrant/scripts/custom/${provisioner}" ]]; then
  for f in /vagrant/scripts/custom/${provisioner}/*.sh; do
    ${f}
  done
else
  for f in /vagrant/scripts/${provisioner}/*.sh; do
    ${f}
  done
fi
