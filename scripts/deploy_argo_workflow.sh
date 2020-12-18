#!/bin/bash

set -e

clear

echo '_________________________'
echo "   __ _ _ __ __ _  ___   "
echo "  / _' | '__/ _' |/ _ \  "
echo " | (_| | | | (_| | (_) | "
echo "  \__,_|_|  \__, |\___/  "
echo "            |___/        "
echo '_________________________'

echo ''
echo '---> Switch to argo namespace context <---'
kubectl config set-context argo --namespace=argo

echo ''
echo '---> Install argo into namespace <---'
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo/stable/manifests/install.yaml

echo ''
echo '---> Set up access to argo ui <---'
kubectl -n argo port-forward deployment/argo-server 2746:2746 > /dev/null 2>&1 &
# WARNING: Argo UI is very unstable using Ingress --> kubectl apply -f k8s/argo_ui.yaml
# I really wanted to use Argo from the ingress_route/argo perspective to keep things clean, 
# but the app is super unstable using this method...it just keeps crashing :-(

echo ''
echo '---> Install argo cli <---'
argo_version=$(argo version | grep 'argo: ' | cut -d'v' -f2 | xargs)
if [[ "$argo_version" > 1.0.0 ]]; then
  echo 'Argo CLI already installed skipping this step....'
else
  echo 'Argo CLI not installed, lets go ahead and install it....'
  curl -sLO https://github.com/argoproj/argo/releases/download/v2.12.0/argo-linux-amd64.gz
  gunzip argo-linux-amd64.gz
  chmod +x argo-linux-amd64
  sudo mv ./argo-linux-amd64 /usr/local/bin/argo
  argo version
fi

echo ''
echo '-------------'
echo '-- SUCCESS --'
echo '-------------'
echo 'Argo Workflow Management system has been deployed.'