#!/bin/bash

set -e

clear

echo '________________________________________________________'
echo "            _   _  __            _                   "
echo "  __ _ _ __| |_(_)/ _| __ _  ___| |_ ___  _ __ _   _ "
echo " / _' | '__| __| | |_ / _' |/ __| __/ _ \| '__| | | |"
echo "| (_| | |  | |_| |  _| (_| | (__| || (_) | |  | |_| |"
echo " \__,_|_|   \__|_|_|  \__,_|\___|\__\___/|_|   \__, |"
echo "                                               |___/ "
echo '________________________________________________________'

namespace='dev'

echo ''
echo "---> Deploying Artifactory to namespace: $namespace <---"
kubectl apply -f k8s/artifactory.yaml -n $namespace

# Official deployment using Helm. Word of caution: there is a lot of manipulation required with v7.x to get working with k8s ingress.
# foregoing this deployment method in favor of directly with kubectl.
# 
# helm upgrade --install artifactory-oss \
#   --set artifactory.postgresql.postgresqlPassword=password \
#   --set artifactory.nginx.enabled=false \
#   --set artifactory.ingress.enabled=true \
#   --set artifactory.ingress.hosts[0]="artifactory.local" \
#   --namespace $namespace center/jfrog/artifactory-oss
