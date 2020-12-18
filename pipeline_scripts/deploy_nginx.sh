#!/bin/bash

export KUBECONFIG="$(k3d kubeconfig write k3s-default)"

# Create deployment, service, and ingress
kubectl apply -f nginx-web/deployment.yaml
kubectl apply -f nginx-web/service.yaml
kubectl apply -f nginx-web/ingress.yaml