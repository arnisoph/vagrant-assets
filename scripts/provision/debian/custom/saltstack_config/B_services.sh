#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

minion_config_path=/vagrant/share/salt-config/${HOSTNAME}/config/minion
master_config_path=/vagrant/share/salt-config/${HOSTNAME}/config/master

[[ -f $minion_config_path ]] && cp $minion_config_path /etc/salt/
[[ -f $master_config_path ]] && cp $master_config_path /etc/salt/

echo "Finishing ${0}.."
