#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

update_dist=$ENV_basic_update_dist
pkg_proxy_uri=$ENV_basic_pkg_proxy_uri

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

apt-get update

[[ "$update_dist" == 'true' ]] && DEBIAN_FRONTEND=noninteractive apt-get -yV upgrade
DEBIAN_FRONTEND=noninteractive apt-get -yV install tree vim bash-completion apt-transport-https bind9-host

echo "Finishing ${0}.."
