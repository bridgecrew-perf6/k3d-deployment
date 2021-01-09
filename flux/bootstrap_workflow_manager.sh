#!/bin/bash

set -e

# Check if environment is ready for flux
kubectl config use-context k3d-workflow-manager
flux check --pre

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=kubernetes \
  --branch=master \
  --path=./clusters/workflow-manager \
  --personal
