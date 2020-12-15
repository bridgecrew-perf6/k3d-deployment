#!/bin/bash

clear
cluster_name=${1}

if [ -z ${cluster_name} ]; then
  echo 'ERROR: cluster name argument not defined, please pass the desired cluster name as an argument.'
  exit 1
else
  echo "Creating cluster: ${cluster_name}"
  echo '------------------------------------------------------'
fi

cluster_exists=$(k3d cluster list --no-headers | cut -d' ' -f1)
if [ "${cluster_exists}" == "${cluster_name}" ]; then
  echo 'Cluster exists! Cluster WILL NOT be created, skipping....'
  echo 'Cluster(s) Deployed:'
  k3d cluster list --no-headers | cut -d' ' -f1
else
  echo "Creating cluster ${cluster_name}"
  # NOTE this is very specific to deploying a cluster with this port mapping, will need to refactor later....
  k3d cluster create $CLUSTER_NAME --api-port 6550 -p "9090:80@loadbalancer" --agents 1
  export KUBECONFIG="$(k3d kubeconfig write k3s-default)"
  echo 'Cluster Deployed:'
  k3d cluster list --no-headers | cut -d' ' -f1
fi
