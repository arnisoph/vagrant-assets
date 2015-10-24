#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ "$PACKER_BUILDER_TYPE" =~ virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-vmx ]]; then
  sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config
  sed -i 's/#RSAAuthentication yes/RSAAuthentication yes/g' /etc/ssh/sshd_config
  sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
  sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
  sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config #TODO
fi

echo "Finishing ${0}.."
