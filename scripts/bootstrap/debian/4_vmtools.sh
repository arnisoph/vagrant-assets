#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ "$PACKER_BUILDER_TYPE" =~ virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-vmx ]]; then
  DEBIAN_FRONTEND=noninteractive apt-get -yV install linux-headers-$(uname -r)
fi

case "$PACKER_BUILDER_TYPE" in

virtualbox-iso|virtualbox-ovf)
    VER=$(cat /etc/vbox_version)
    mount -o loop /tmp/VBoxGuestAdditions_$VER.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run
    umount /mnt
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
;;

vmware-iso|vmware-ovf)
    mkdir /tmp/vmfusion
    mkdir /tmp/vmfusion-archive
    mount -o loop /tmp/linux.iso /tmp/vmfusion
    tar xzf /tmp/vmfusion/VMwareTools-*.tar.gz -C /tmp/vmfusion-archive
    /tmp/vmfusion-archive/vmware-tools-distrib/vmware-install.pl --default
    umount /tmp/vmfusion
    rm -rf  /tmp/vmfusion
    rm -rf  /tmp/vmfusion-archive
    rm /tmp/*.iso
;;

parallels-iso|parallels-pvm)
    mkdir /tmp/parallels
    mount -o loop /tmp/prl-tools-lin.iso /tmp/parallels
    /tmp/parallels/install --install-unattended-with-deps
    umount /tmp/parallels
    rmdir /tmp/parallels
    rm /tmp/*.iso
;;

docker)
    echo "No guest additions will be installed (\$PACKER_BUILDER_TYPE=${PACKER_BUILDER_TYPE})"
;;

*)
    echo "Unknown Packer Builder Type >>$PACKER_BUILDER_TYPE<< selected."
    echo "Known are virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-ovf."
;;

esac

echo "Finishing ${0}.."
