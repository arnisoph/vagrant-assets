#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

yum -y update

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
