#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

date > /etc/vagrant_box_build_time

if [[ -n "${ROOT_PASSWORD}" ]]; then
  echo "root:${ROOT_PASSWORD}" | /usr/sbin/chpasswd
fi

if [[ -n "${TEMP_DISABLE_IPV6}" ]]; then
  echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
fi

echo "Finishing ${0}.."
