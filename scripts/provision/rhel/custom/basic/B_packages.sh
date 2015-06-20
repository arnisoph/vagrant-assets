#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

update_dist=$ENV_basic_update_dist
pkg_proxy_uri=$ENV_basic_pkg_proxy_uri

if [[ -n "$pkg_proxy_uri" ]]; then
  echo "proxy=${pkg_proxy_uri}" >> /etc/yum.conf
fi

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
