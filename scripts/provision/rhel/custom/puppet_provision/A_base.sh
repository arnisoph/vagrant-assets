#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

puppet apply \
  --ignorecache \
  --verbose \
  --show_diff \
  --detailed-exitcodes \
  --modulepath=/vagrant/shared/puppet/modules_custom/:/vagrant/shared/puppet/modules/:/vagrant/shared/puppet/modules_dist/:/vagrant/shared/puppet_modules_ext \
  --hiera_config=/vagrant/shared/puppet/hiera.yaml \
  /vagrant/shared/puppet/manifests/$(hostname -s)/default.pp

echo "Finishing ${0}.."
