#!/bin/bash

set -e

# Check if environment is ready for flux
kubectl config use-context k3d-artifact-manager
flux check --pre

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=kubernetes \
  --branch=master \
  --path=./clusters/artifact-manager \
  --personal
