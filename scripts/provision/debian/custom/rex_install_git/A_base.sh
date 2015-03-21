#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

echo "deb https://rex.linux-files.org/debian/ $(lsb_release -cs) rex" > /etc/apt/sources.list.d/rex.list
wget -O - https://rex.linux-files.org/DPKG-GPG-KEY-REXIFY-REPO | apt-key add -
apt-get update

# apt-cache depends rex | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' '

DEBIAN_FRONTEND=noninteractive apt-get -y install \
  cpanminus \
  libdbi-perl \
  libdigest-hmac-perl \
  libexpect-perl \
  libipc-shareable-perl \
  libjson-xs-perl \
  liblist-moreutils-perl \
  liblwp-protocol-https-perl \
  libnet-ssh2-perl \
  libparallel-forkmanager-perl \
  libssl-dev \
  libstring-escape-perl \
  libterm-readkey-perl \
  libtext-glob-perl \
  libwww-perl \
  libxml-libxml-perl \
  libxml-simple-perl \
  libyaml-perl

cd /vagrant/src/rex
cpanm Dist::Zilla
dzil authordeps --missing | cpanm
dzil listdeps --missing | cpanm
dzil install

echo "Finishing ${0}.."
