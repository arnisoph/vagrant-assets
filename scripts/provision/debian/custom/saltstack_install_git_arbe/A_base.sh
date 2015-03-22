#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -z "$(which salt-call)" ]]; then
  wget https://raw.githubusercontent.com/saltstack/salt-bootstrap/stable/bootstrap-salt.sh
  chmod +x bootstrap-salt.sh
  ./bootstrap-salt.sh -M -K -g https://github.com/bechtoldt/salt.git git 2014.7-arbe
fi

echo "$(hostname -f)" > /etc/salt/minion_id

echo "Finishing ${0}.."
