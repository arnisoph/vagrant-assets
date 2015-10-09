#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

update_dist=$ENV_basic_update_dist
pkg_proxy_uri=$ENV_basic_pkg_proxy_uri

#TODO manage repo files

yum -y install \
  epel-release \
  ed

[[ -e /etc/yum/pluginconf.d/fastestmirror.conf ]] && ed -s /etc/yum/pluginconf.d/fastestmirror.conf <<< $',s/enabled=1/enabled=0/g\nw' \;

if [[ -n "$pkg_proxy_uri" ]]; then
  echo "proxy=${pkg_proxy_uri}" >> /etc/yum.conf
  find /etc/yum.repos.d/ -type f -name '*.repo' -exec ed -s {} <<< $',s/#baseurl=/baseurl=/g\nw' \;
  find /etc/yum.repos.d/ -type f -name '*.repo' -exec ed -s {} <<< $',s/mirrorlist=/#mirrorlist=/g\nw' \;
fi

[[ "$update_dist" == 'true' ]] && yum -y update

yum -y install \
  perl \
  make \
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
