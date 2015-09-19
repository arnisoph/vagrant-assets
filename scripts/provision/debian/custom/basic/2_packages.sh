#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

update_dist=$ENV_basic_update_dist
pkg_proxy_uri=$ENV_basic_pkg_proxy_uri
manage_sources_list=$ENV_basic_manage_sources_list

if [[ -n "$pkg_proxy_uri" ]]; then
cat <<EOF > /etc/apt/apt.conf.d/999_vagrant_proxy
Acquire {
  ftp::Proxy "${pkg_proxy_uri}";
  http::Proxy "${pkg_proxy_uri}";
  https::Proxy "${pkg_proxy_uri}";
  ssh::Proxy "";
}
EOF
fi

if [[ "$manage_sources_list" == true ]]; then #TODO make it more configurable
cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian wheezy main contrib non-free
deb-src http://ftp.debian.org/debian wheezy main contrib non-free

deb http://security.debian.org/ wheezy/updates main contrib non-free
deb-src http://security.debian.org/ wheezy/updates main contrib non-free

deb http://ftp.debian.org/debian wheezy-updates main contrib non-free
deb-src http://ftp.debian.org/debian wheezy-updates main contrib non-free

deb http://ftp.debian.org/debian wheezy-backports main contrib non-free
deb-src http://ftp.debian.org/debian wheezy-backports main contrib non-free
EOF
fi

apt-get -q update

[[ "$update_dist" == 'true' ]] && DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install tree vim bash-completion apt-transport-https bind9-host

echo "Finishing ${0}.."
