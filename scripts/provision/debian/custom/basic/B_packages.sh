#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

update_dist=$ENV_basic_update_dist
[[ -z "$update_dist" ]] && update_dist=false

apt-get update

[[ "$update_dist" == 'true' ]] && DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install tree vim bash-completion apt-transport-https bind9-host

echo "Finishing ${0}.."
