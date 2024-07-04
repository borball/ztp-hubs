#!/bin/bash
# install openshift cluster and required operators for the ZTP hub

BASEDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
WORKSPACE="$BASEDIR"/workspace

clone_repo(){
  rm -rf "$WORKSPACE"
  git clone https://github.com/borball/mno-with-abi.git "$WORKSPACE"
}

install_hub(){
  cd "$WORKSPACE"/test/hub
  ./install-hub.sh
}

day2(){
  cd "$WORKSPACE"
  ./mno-day2.sh test/hub/cluster-config.yaml
}

clone_repo
install_hub
day2