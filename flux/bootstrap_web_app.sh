#!/bin/bash

set -e

# Check if environment is ready for flux
kubectl config use-context k3d-web-application
flux check --pre

flux bootstrap github \
  --components-extra=image-reflector-controller,image-automation-controller \
  --owner=$GITHUB_USER \
  --repository=kubernetes \
  --branch=master \
  --path=./clusters/web-application \
  --personal
