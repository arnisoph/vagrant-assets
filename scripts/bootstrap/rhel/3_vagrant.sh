#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

# configure /etc/sudoers
test -e /etc/sudoers && sed -i 's/^.*requiretty/#Defaults requiretty/' /etc/sudoers

# configure /etc/profile.d/
echo "export env_keep=SSH_AUTH_SOCK" > /etc/profile.d/export_env_keep.sh

if [[ "$PACKER_BUILDER_TYPE" =~ virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-vmx ]]; then
  # add vagrant user
  groupadd vagrant
  useradd vagrant -g vagrant -G wheel
  echo "vagrant" | passwd --stdin vagrant
  echo "vagrant   ALL=(ALL)   NOPASSWD: ALL" >> /etc/sudoers

  # add vagrant keys
  mkdir -pm 700 /home/vagrant/.ssh
  wget --no-check-certificate http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
  chmod 0600 /home/vagrant/.ssh/authorized_keys
  chown -R vagrant:vagrant /home/vagrant/.ssh
fi

echo "Finishing ${0}.."
