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
CLUSTER_NAME='web-application'

k3d cluster create $CLUSTER_NAME --api-port 6550 -p '80:80@loadbalancer' -v /mnt/d/k8s_datastore:/cluster_datastore --agents 3 --wait

export KUBECONFIG="$(k3d kubeconfig write ${CLUSTER_NAME})"

echo ''
echo '---> Creating namespace(s) <---'
kubectl create namespace dev
kubectl create namespace stage
kubectl create namespace prod

echo ''
echo '---> Create namespace contexts <---'
kubectl config set-context dev --namespace=dev
kubectl config set-context stage --namespace=stage
kubectl config set-context prod --namespace=prod

kubectl get ns

echo ''
echo '-------------'
echo '-- SUCCESS --'
echo '-------------'
echo 'Cluster has been created, along with supporting namespaces,'
echo 'you can now deploy to the desired namespace(s).'

current_context=$(kubectl config current-context)
echo "Current context is: $current_context"