#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ $(grep -E '^[A-Za-z ]*7\.' /etc/redhat-release) ]]; then
  #TODO make this configurable:
  timedatectl set-timezone Europe/Berlin
  systemctl stop firewalld
  systemctl disable firewalld
fi

echo "Finishing ${0}.."
