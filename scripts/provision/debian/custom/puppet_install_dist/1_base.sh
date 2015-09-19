#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

setup_hiera_eyaml=$ENV_puppet_install_dist_setup_hiera_eyaml
[[ -z "$setup_hiera_eyaml" ]] && setup_hiera_eyaml=false

IFS=','
puppet_packages=( $ENV_puppet_install_dist_puppet_packages )
unset IFS
[[ -z "$puppet_packages" ]] && puppet_packages=(puppet ruby-deep-merge)

if [[ -z "$(which puppet)" ]]; then
  wget -O /tmp/puppetlabs-release.deb https://apt.puppetlabs.com/puppetlabs-release-$(lsb_release -cs).deb
  dpkg -i /tmp/puppetlabs-release.deb

  apt-get -q update
fi

DEBIAN_FRONTEND=noninteractive apt-get -yV install ${puppet_packages[@]}

if [[ "$setup_hiera_eyaml" == 'true' ]]; then
  gem install --verbose hiera-eyaml
  mkdir -p /etc/puppet/secure/hiera-eyaml/ /etc/eyaml/
  cat > /etc/eyaml/config.yaml <<EOF
---
pkcs7_private_key: /etc/puppet/secure/hiera-eyaml/private_key.pkcs7.pem
pkcs7_public_key: /etc/puppet/secure/hiera-eyaml/public_key.pkcs7.pem
EOF
  eyaml createkeys --verbose --pkcs7-private-key=/etc/puppet/secure/hiera-eyaml/private_key.pkcs7.pem --pkcs7-public-key=/etc/puppet/secure/hiera-eyaml/public_key.pkcs7.pem
fi

echo "Finishing ${0}.."
