#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

IFS=';'
provisioners_context=( ${CUSTOM_PROVISIONERS_CONTEXT} )
unset IFS

for p in ${provisioners_context[@]}; do
  echo "export ${p}" >> /tmp/provisioners_context.sh
done

IFS=','
provisioners=( ${CUSTOM_PROVISIONERS} )
unset IFS

for p in ${provisioners[@]}; do
  dir=/tmp/packer-provision/provision/custom/${p}
  if [[ -d $dir ]]; then
    for f in ${dir}/*.sh; do
      ${f}
    done
  fi
done

echo "Finishing ${0}.."
