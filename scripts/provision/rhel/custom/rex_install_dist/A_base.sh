#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

rpm --import https://rex.linux-files.org/RPM-GPG-KEY-REXIFY-REPO.CENTOS6

cat >/etc/yum.repos.d/rex.repo <<EOF
[rex]
name=Fedora \$releasever - \$basearch - Rex Repository
baseurl=https://rex.linux-files.org/CentOS/\$releasever/rex/\$basearch/
enabled=1
EOF

yum makecache
yum -y install rex

echo "Finishing ${0}.."
