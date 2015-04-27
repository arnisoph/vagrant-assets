#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

puppet apply \
  --test \
  --modulepath=/vagrant/share/puppet/modules_custom/:/vagrant/share/puppet/modules/:/vagrant/share/puppet/modules_dist/ \
  --hiera_config=/vagrant/share/puppet/hiera.yaml \
  /vagrant/share/puppet/manifests/default.pp

echo "Finishing ${0}.."
