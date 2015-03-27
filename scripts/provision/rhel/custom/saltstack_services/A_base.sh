#!/bin/bash
# TODO it might be better to use systemctl on RHEL >= 7.0

echo '##############################################'
echo "Starting ${0}.."
set -x

echo "Restarting all Salt services.."

[[ -n "$(which salt-master)" ]] && service salt-master restart
[[ -n "$(which salt-syndic)" ]] && service salt-syndic restart
[[ -n "$(which salt-minion)" ]] && service salt-minion restart

echo "Finishing ${0}.."
