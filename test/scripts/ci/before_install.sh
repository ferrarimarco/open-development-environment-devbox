#!/bin/sh -eux

wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip -d packer packer_${PACKER_VERSION}_linux_amd64.zip
echo 'Packer Version: '"$(./packer/packer --version)"

gem install bundle
