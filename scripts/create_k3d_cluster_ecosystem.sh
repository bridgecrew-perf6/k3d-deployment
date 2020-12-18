#!/bin/bash

set -e

clear

echo '______________________'
echo "   _  _______ ____  "
echo "  | |/ /___ /|  _ \ "
echo "  | ' /  |_ \| | | |"
echo "  | . \ ___) | |_| |"
echo "  |_|\_\____/|____/ "
echo '______________________'

echo ''
echo '---> Creating K3D cluster <---'
CLUSTER_NAME='black-pearl'
k3d cluster create $CLUSTER_NAME --api-port 6555 -p '9080:80@loadbalancer' -v /mnt/d/k8s_datastore:/cluster_datastore --agents 5 --wait
export KUBECONFIG="$(k3d kubeconfig write k3d-${CLUSTER_NAME})"

echo ''
echo '---> Creating namespace(s) <---'
kubectl create -f k8s/namespaces.yaml

echo ''
echo '---> Create namespace contexts <---'
kubectl config set-context dev --namespace=dev
kubectl config set-context stage --namespace=stage
kubectl config set-context prod --namespace=prod
kubectl config set-context argo --namespace=argo

echo ''
echo '-------------'
echo '-- SUCCESS --'
echo '-------------'
echo 'Cluster has been created, along with supporting namespaces,'
echo 'you can now deploy content(s) to the desired namespace(s).'

current_context=$(kubectl config current-context)
echo "Current context is: $current_context"