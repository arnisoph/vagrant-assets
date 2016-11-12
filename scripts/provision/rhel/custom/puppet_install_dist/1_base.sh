#!/bin/bash

# Authors:
#
# * Alexander Pacnik <alexander.pacnik@inovex.de>
# * Arnold Bechtoldt <arnold.bechtoldt@inovex.de>

echo '##############################################'
echo "Starting ${0}.."
set -x

[[ -z "$setup_hiera_eyaml" ]] && setup_hiera_eyaml=false

IFS=','
puppet_packages=( $puppet_packages )
unset IFS
[[ -z "$puppet_packages" ]] && puppet_packages=(puppet rubygem-deep_merge)

# add EL puppetlabs repository
majorver=6
if [[ $(grep -E '^[A-Za-z ]*7\.' /etc/redhat-release) ]]; then
  majorver=7
fi

if [[ -z "$(which puppet)" ]]; then
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-${majorver}.noarch.rpm
  yum makecache
fi

yum -y install ${puppet_packages[@]}

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
