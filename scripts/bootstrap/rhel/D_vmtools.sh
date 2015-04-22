#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  # Centos 6.5 bug workaround
  if [[ $(grep -E '^[A-Za-z ]*6\.5' /etc/redhat-release) ]]; then
    cd /usr/src/kernels/*/include/drm
    ln -s /usr/include/drm/drm.h drm.h
    ln -s /usr/include/drm/drm_sarea.h drm_sarea.h
    ln -s /usr/include/drm/drm_mode.h drm_mode.h
    ln -s /usr/include/drm/drm_fourcc.h drm_fourcc.h
  fi

  ## optional: add Centos 6 dkms support, always downloads latest available
  #if [[ $(grep ' 6.' /etc/redhat-release) ]]; then
  #  #wget -P /tmp -nd -nc -A rpm -l1 -r http://ftp.hosteurope.de/mirror/fedora-epel/6/x86_64/ --accept-regex 'dkms.+rpm$'
  #  sudo rpm -ivh /tmp/dkms*
  #fi

  ## optional: add Centos 7 dkms support, always downloads latest available
  #if [[ $(grep ' 7.' /etc/redhat-release) ]]; then
  #  wget -P /tmp/  -nd -nc -A rpm -l1 -r http://ftp.hosteurope.de/mirror/fedora-epel/7/x86_64/d/ --accept-regex 'dkms.+rpm$'
  #  sudo rpm -ivh /tmp/dkms*
  #fi
  # the following requires the EPEL repo
  yum -y install dkms

  # install VirtualBox guest additions
  VBOX_VERSION=$(cat /etc/vbox_version)
  mount -o loop /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run --nox11

  # clean up
  umount /mnt
  rm -rf /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso

  # show client version
  /opt/VBoxGuestAdditions-$(cat /etc/vbox_version)/bin/VBoxControl --version
fi

if [[ $PACKER_BUILDER_TYPE =~ vmware ]]; then
  # install vmware tools via official package repositories
  # (http://packages.vmware.com/tools/versions)

  # import vmware repository keys
  rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-DSA-KEY.pub
  rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub

  # add repository # TODO is this still required on el7?
  echo '[vmware-tools]' > /etc/yum.repos.d/vmware-tools.repo
  echo 'name=VMware Tools' >> /etc/yum.repos.d/vmware-tools.repo
  echo 'baseurl=http://packages.vmware.com/tools/esx/5.5p01/rhel6/x86_64/' >> /etc/yum.repos.d/vmware-tools.repo
  echo 'enabled=1' >> /etc/yum.repos.d/vmware-tools.repo
  echo 'gpgcheck=1' >> /etc/yum.repos.d/vmware-tools.repo

  # install vmware tools
  yum -y install vmware-tools-esx-nox
fi

echo "Finishing ${0}.."
