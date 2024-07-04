#!/bin/bash
# create empty kvm and install SNO

BASEDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

oc apply -k "$BASEDIR"/extra-manifests 2>/dev/null

oc wait --for condition=established crd agentserviceconfigs.agent-install.openshift.io --timeout=180s

oc apply -f "$BASEDIR"/extra-manifests/AgentServiceConfig.yaml

oc get pods -n multicluster-engine -w

