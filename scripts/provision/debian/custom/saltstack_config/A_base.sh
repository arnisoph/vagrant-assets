#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -z "$(which salt-call)" ]]; then
  echo "Can't config Salt, couldn't find salt-call in '${PATH}'.."
  exit 1
fi

minion_config_path=/vagrant/share/salt-config/${HOSTNAME}/config/minion
master_config_path=/vagrant/share/salt-config/${HOSTNAME}/config/master


# SALT-MINION
if [[ -f $minion_config_path ]]; then
  cp $minion_config_path /etc/salt/
else
  cat << EOF > /etc/salt/minion
file_roots:
  base:
    - /srv/salt/states
    - /srv/salt/contrib/states

pillar_roots:
  base:
    - /srv/salt/pillar

module_dirs:
  - /srv/salt/_modules/common
  - /srv/salt/_modules/formulas

file_client: local
EOF
fi


# SALT-MASTER
if [[ -f $master_config_path ]]; then
  cp $master_config_path /etc/salt/
else
  #TODO
  cat << EOF > /etc/salt/master
file_roots:
  base:
    - /srv/salt/states
    - /srv/salt/contrib/states

pillar_roots:
  base:
    - /srv/salt/pillar
EOF
fi
