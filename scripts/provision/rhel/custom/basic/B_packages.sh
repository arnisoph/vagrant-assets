#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

update_dist=$ENV_basic_update_dist
[[ -z "$update_dist" ]] && update_dist=false

[[ "$update_dist" == 'true' ]] && yum -y update

yum -y install \
  epel-release \

yum -y install \
  perl \
  make \
  gcc \
  bzip2 \
  curl \
  dhclient \
  less \
  logrotate \
  openssh \
  rsync \
  sudo \
  unzip \
  wget \
  which \
  tree \
  vim \
  bash-completion \
  bind-utils

echo "Finishing ${0}.."
