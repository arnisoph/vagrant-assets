#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

timezone=$ENV_basic_timezone
[[ -z "$timezone" ]] && timezone=Europe/Berlin

if [[ $(grep -E '^[A-Za-z ]*7\.' /etc/redhat-release) ]]; then
  timedatectl set-timezone $timezone
  systemctl stop firewalld
  systemctl disable firewalld
fi

if [[ -d /vagrant/shared/misc/tools/ && -d /etc/profile.d/ ]]; then
  echo 'export PATH=${PATH}:/vagrant/shared/misc/tools/' > /etc/profile.d/vagrant_basic.sh
fi

echo "Finishing ${0}.."
