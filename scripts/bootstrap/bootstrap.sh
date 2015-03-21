#!/bin/bash

find /tmp/packer-provision/bootstrap/ -type f -name '*.sh' -print -exec chmod +x {} \;

for f in /tmp/packer-provision/bootstrap/*.sh; do
  source ${f}
done

rm -rf /tmp/*
