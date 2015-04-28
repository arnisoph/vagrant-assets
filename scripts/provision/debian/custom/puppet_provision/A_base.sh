#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

puppet apply \
  --ignorecache \
  --verbose \
  --show_diff \
  --detailed-exitcodes \
  --modulepath=/vagrant/share/puppet/modules_custom/:/vagrant/share/puppet/modules/:/vagrant/share/puppet/modules_dist/ \
  --hiera_config=/vagrant/share/puppet/hiera.yaml \
  /vagrant/share/puppet/manifests/$(hostname -s)/default.pp

echo "Finishing ${0}.."
