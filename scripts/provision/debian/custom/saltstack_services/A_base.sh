#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

[[ -n "$(which salt-master)" ]] && service salt-master restart
[[ -n "$(which salt-syndic)" ]] && service salt-syndic restart
[[ -n "$(which salt-minion)" ]] && service salt-minion restart

echo "Finishing ${0}.."
