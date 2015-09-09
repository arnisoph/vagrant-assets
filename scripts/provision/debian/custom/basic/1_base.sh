#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -d /vagrant/shared/misc/tools/ && -d /etc/profile.d/ ]]; then
  echo 'export PATH=${PATH}:/vagrant/shared/misc/tools/' > /etc/profile.d/vagrant_basic.sh
fi

echo "Finishing ${0}.."
