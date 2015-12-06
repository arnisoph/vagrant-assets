#!/bin/bash

echo '##############################################'
echo "Starting ${0}.."
set -x

link_it() {
  src=$1
  dst=$2
  if [[ -e $src && ! -e $dst ]]; then ln -s $src $dst || exit 1; fi
}

states_top_path=/vagrant/shared/salt/devenv/$(hostname -s)/file_roots/states/top.sls
pillar_root=/vagrant/shared/salt/devenv/$(hostname -s)/file_roots/pillar/

#mkdir -p /srv/salt/{_grains,_modules/formulas,_states,contrib/states,contrib/reactor,pillar/examples,states}
mkdir -p /srv/salt/{_grains,_modules,_states,contrib/states,contrib/reactor,pillar/examples,states}
mkdir -p /vagrant/shared/misc

[[ -f $states_top_path ]] && ln -sf $states_top_path /srv/salt/states/top.sls
[[ -d $pillar_root && ! -e /srv/salt/pillar/shared ]] && ln -sf $pillar_root /srv/salt/pillar/shared

if [[ -d /vagrant/salt/formulas/ ]]; then
  for d in /vagrant/salt/formulas/*; do
    if [[ -d ${d}/states ]]; then
      link_it ${d}/states /srv/salt/states/${d##*/}
    else
      link_it ${d}/${d##*/} /srv/salt/states/${d##*/}
    fi

    if [[ -d ${d}/contrib/states ]]; then
      link_it ${d}/contrib/states /srv/salt/contrib/states/${d##*/}
    elif [[ -d ${d}/contrib/files ]]; then
      link_it ${d}/contrib /srv/salt/contrib/states/${d##*/}
    fi

    if [[ -d ${d}/contrib/reactor ]]; then
      link_it ${d}/contrib/reactor /srv/salt/contrib/reactor/${d##*/}
    fi

    link_it ${d}/pillar_examples /srv/salt/pillar/examples/${d##*/}

    [[ -d ${d}/_modules ]] && find ${d}/_modules -type f -name '*.py' -exec ln -sf {} /srv/salt/_modules/ \;
    [[ -d ${d}/_states ]] && find ${d}/_states -type f -name '*.py' -exec ln -sf {} /srv/salt/_states/ \;
  done
fi

[[ -d /vagrant/salt/_modules/ ]] && find /vagrant/salt/_modules/ -type f -name '*.py' -exec ln -sf {} /srv/salt/_modules/ \;
[[ -d /vagrant/salt/_states/ ]] && find /vagrant/salt/_states/ -type f -name '*.py' -exec ln -sf {} /srv/salt/_states/ \;
#[[ -d /vagrant/salt/_modules/ ]] && link_it /vagrant/salt/_modules/ /srv/salt/_modules/common
#[[ -d /vagrant/salt/_states/ ]] && link_it /vagrant/salt/_states/ /srv/salt/_states/common

echo "Finishing ${0}.."
