#!/bin/sh -eu

wget https://releases.hashicorp.com/packer/"$PACKER_VERSION"/packer_"$PACKER_VERSION"_linux_amd64.zip
unzip -d packer packer_"$PACKER_VERSION"_linux_amd64.zip
mv ./packer/packer /usr/local/bin/packer
installed_packer_version="$(packer --version)"

if [ "$PACKER_VERSION" = "$installed_packer_version" ]; then
  echo "Packer Version: $installed_packer_version"
else
  packer_path="$(which packer)"
  "Expected Packer version: $PACKER_VERSION. Installed Packer version: $installed_packer_version. Packer path: $packer_path"
  exit 1;
fi
