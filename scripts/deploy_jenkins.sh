#!/bin/bash

set -e

clear

echo '____________________________________'
echo "   _            _    _           "
echo "  (_) ___ _ __ | | _(_)_ __  ___ "
echo "  | |/ _ \ '_ \| |/ / | '_ \/ __|"
echo "  | |  __/ | | |   <| | | | \__ \\"
echo " _/ |\___|_| |_|_|\_\_|_| |_|___/"
echo "|__/                             "
echo '____________________________________'

namespace='dev'

echo ''
echo "---> Deploying Jenkins Master to namespace: $namespace <---"
kubectl apply -f k8s/jenkins.yaml -n $namespace
