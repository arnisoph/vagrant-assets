#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

cat /tmp/provisioners_context.sh
source /tmp/provisioners_context.sh

IFS=','
bootstrap_params=( $saltstack_install_bootstrap_params )
unset IFS

if [[ -z "$(which salt-call)" ]]; then
  wget https://raw.githubusercontent.com/saltstack/salt-bootstrap/stable/bootstrap-salt.sh
  chmod +x bootstrap-salt.sh
  ./bootstrap-salt.sh ${bootstrap_params[@]}
fi

echo "$(hostname -f)" > /etc/salt/minion_id

echo "Finishing ${0}.."
