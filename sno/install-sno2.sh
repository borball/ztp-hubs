#!/bin/bash
# create empty kvm and install SNO

BASEDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
WORKSPACE="$BASEDIR"/workspace

create_empty_kvm(){
  ssh 192.168.58.14 'kcli create vm -P uuid=11111111-1111-1111-9999-000000000000 -P start=False -P memory=65536 -P numcpus=48 -P disks=[120,100,100] -P nets=["{\"name\":\"br-vlan58\",\"nic\":\"eth0\",\"mac\":\"de:ad:be:ff:10:75\"}"] hub2'
}

restart_sushy(){
  systemctl restart sushy-tools.service
}

delete_kvm(){
  ssh 192.168.58.14 kcli stop vm hub2
  ssh 192.168.58.14 kcli delete vm hub2 -y
}

install_sno(){
  rm -rf "$WORKSPACE"
  git clone https://github.com/borball/sno-agent-based-installer "$WORKSPACE"
  cp "$BASEDIR"/config-hub2.yaml "$WORKSPACE"/
  cd "$WORKSPACE"
  ./sno-iso.sh config-hub2.yaml latest-4.16
  cp "$WORKSPACE"/instances/hub2/agent.x86_64.iso /var/www/html/iso/agent-hub2.iso
  ./sno-install.sh config-hub2.yaml
}

delete_kvm
create_empty_kvm
restart_sushy
install_sno
