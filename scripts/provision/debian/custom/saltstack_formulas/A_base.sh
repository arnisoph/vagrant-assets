#!/bin/bash
#TODO update config with /vagrant/share/fooo (master & minion config) + pillar, etc.
#TODO move dir creation to this file instead of saltstack_setup

echo '##############################################'
echo "Starting ${0}.."
set -x

link_it() {
  src=$1
  dst=$2
  if [[ -e $src && ! -e $dst ]]; then ln -s $src $dst || exit 1; fi
}

states_top_path=/vagrant/share/salt/devenv/$(hostname -s)/file_roots/states/top.sls
pillar_root=/vagrant/share/salt/devenv/$(hostname -s)/file_roots/pillar/

mkdir -p /srv/salt/{_grains,_modules/formulas,_states,contrib/states,pillar/examples,states}
mkdir -p /vagrant/share/misc

[[ -f $states_top_path ]] && ln -sf $states_top_path /srv/salt/states/top.sls
[[ -d $pillar_root && ! -e /srv/salt/pillar/share ]] && ln -sf $pillar_root /srv/salt/pillar/share

if [[ -d /vagrant/salt/formulas/ ]]; then
  for d in /vagrant/salt/formulas/*; do
    if [[ -d ${d}/states ]]; then
      link_it ${d}/states /srv/salt/states/${d##*/}
    else
      link_it ${d}/${d##*/} /srv/salt/states/${d##*/}
    fi

    [[ -d ${d}/contrib/states ]] && link_it ${d}/contrib/states /srv/salt/contrib/states/${d##*/}

    link_it ${d}/pillar_examples /srv/salt/pillar/examples/${d##*/}

    src=${d}/_modules
    dst=/srv/salt/_modules/formulas/${f##*/}
    if [[ -d $src ]]; then
      find $d -type f -name '*.py' -exec ln -sf {} $dst \; || exit 1
    fi
  done
fi

[[ -d /vagrant/salt/_modules/ ]] && link_it /vagrant/salt/_modules/ /srv/salt/_modules/common
[[ -d /vagrant/salt/_states/ ]] && link_it /vagrant/salt/_states/ /srv/salt/_states/common

echo "Finishing ${0}.."
