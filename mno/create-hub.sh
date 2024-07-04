#!/bin/bash
# create ZTP hub instance

BASEDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

oc apply -f "$BASEDIR"/agent-service-config.yaml

oc get pods -n multicluster-engine -w

