#!/bin/bash

# Authors:
#
# * Alexander Pacnik <alexander.pacnik@inovex.de>
# * Arnold Bechtoldt <arnold.bechtoldt@inovex.de>

echo '##############################################'
echo "Starting ${0}.."
set -x

# add EL puppetlabs repository
majorver=6
if [[ $(grep -E '^[A-Za-z ]*7.' /etc/redhat-release) ]]; then
  majorver=7
fi

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-${majorver}.noarch.rpm

yum -y --enablerepo=puppetlabs-products install puppet

echo "Finishing ${0}.."
