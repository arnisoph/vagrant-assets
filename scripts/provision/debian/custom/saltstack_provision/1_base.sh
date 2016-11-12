#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

# if $sls is empty, all state files will be applied (= state.highstate)
salt-call -l info state.apply $sls

echo "Finishing ${0}.."
