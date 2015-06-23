#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -z "$(which salt-call)" ]]; then
  echo "Can't config Salt, couldn't find salt-call in '${PATH}'.."
  exit 1
fi

minion_config_path=/vagrant/shared/salt/devenv/$(hostname -s)/config/minion
master_config_path=/vagrant/shared/salt/devenv/$(hostname -s)/config/master
salt_master=$ENV_saltstack_config_salt_master

# SALT-MINION
if [[ -f $minion_config_path ]]; then
  cp $minion_config_path /etc/salt/
  #ln -s $minion_config_path /etc/salt/minion
else
  cat << EOF > /etc/salt/minion
file_roots:
  base:
    - /srv/salt/states
    - /srv/salt/contrib/states
    - /vagrant/shared

pillar_roots:
  base:
    - /srv/salt/pillar/examples
    - /srv/salt/pillar/shared

module_dirs:
  - /srv/salt/_modules/common
  - /srv/salt/_modules/formulas

states_dirs:
  - /srv/salt/_states/common

file_client: local
EOF
  [[ -n "$salt_master" ]] && echo "master: ${salt_master}" >> /etc/salt/minion
fi

echo "$(hostname -f)" > /etc/salt/minion_id


# SALT-MASTER
if [[ -f $master_config_path ]]; then
  cp $master_config_path /etc/salt/
  #ln -s $master_config_path /etc/salt/master
else
  #TODO
  cat << EOF > /etc/salt/master
autosign_file: /etc/salt/autosign.conf

file_roots:
  base:
    - /srv/salt/states
    - /srv/salt/contrib/states
    - /vagrant/shared

pillar_roots:
  base:
    - /srv/salt/pillar/examples
    - /srv/salt/pillar/shared
EOF
fi

echo "*.$(hostname -d)" > /etc/salt/autosign.conf

echo "Finishing ${0}.."
