#!/bin/bash

# Authors:
#
# * Alexander Pacnik <alexander.pacnik@inovex.de>
# * Arnold Bechtoldt <arnold.bechtoldt@inovex.de>

echo '##############################################'
echo "Starting ${0}.."
set -x

setup_hiera_eyaml=$ENV_puppet_install_dist_setup_hiera_eyaml
[[ -z "$setup_hiera_eyaml" ]] && setup_hiera_eyaml=false

# add EL puppetlabs repository
majorver=6
if [[ $(grep -E '^[A-Za-z ]*7\.' /etc/redhat-release) ]]; then
  majorver=7
fi

if [[ -z "$(which puppet)" ]]; then
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-${majorver}.noarch.rpm

  yum -y --enablerepo=puppetlabs-products install puppet rubygem-deep_merge
else
  yum -y install rubygem-deep_merge
fi

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
