#!/bin/bash

set -e

clear

echo '---> Installing kubectx & kubens <---'
if [ -d '/opt/kubectx' ]; then
  echo '/opt/kubectx exists, skipping....'
else
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
fi

sudo ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -sf /opt/kubectx/kubens /usr/local/bin/kubens

echo ''
echo '---> Testing the instsallation <---'
echo 'CONTEXTS'
kubectx

echo ''
echo 'NAMESPACES'
kubens