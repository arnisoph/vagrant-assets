#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -d /vagrant/shared/misc/tools/ && -d /etc/profile.d/ ]]; then
  echo 'export PATH=${PATH}:/vagrant/shared/misc/tools/' > /etc/profile.d/vagrant_basic.sh
fi

ssh_pubkeys=$ENV_basic_ssh_pubkeys
if [[ -n "${ssh_pubkeys}" ]]; then
  mkdir -p /root/.ssh/
  echo -e "${ssh_pubkeys}" > /root/.ssh/authorized_keys
  chmod 700 /root/.ssh/
  chmod 640 /root/.ssh/authorized_keys
  chown -R root:root /root/.ssh/
fi

echo "Finishing ${0}.."
