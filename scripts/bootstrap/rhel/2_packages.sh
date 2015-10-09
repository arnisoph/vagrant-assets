#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ -n "$MANAGE_SOURCES_LIST" ]]; then #TODO make it more configurable
  true #TODO
fi

yum -y update

yum -y install \
  epel-release

yum -y install \
  bzip2 \
  curl \
  dhclient \
  less \
  logrotate \
  openssh \
  openssh-clients \
  openssh-server \
  rsync \
  sudo \
  unzip \
  wget \
  which \
  bind-utils

echo "Finishing ${0}.."
