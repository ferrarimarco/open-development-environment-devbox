#!/bin/sh -eu

mktouch() {
  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    touch -a -- "$f"
  done
}

# Workaround until we have feedback on https://github.com/hashicorp/packer/issues/5727
mktouch \
  ./builds/virtualbox-iso/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-install-ansible/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-cleanup/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf

# Create a dummy archive to validate its path in the template
mktouch ./provisioning/downloads/sqldeveloper-17.4.0.355.2349-no-jre.zip

VAGRANT_CLOUD_TOKEN=dummy_token packer validate ubuntu.json

kitchen test "$KITCHEN_SCRIPT-$KITCHEN_PLATFORM"

rm -rf ./builds
rm ./provisioning/downloads/sqldeveloper-17.4.0.355.2349-no-jre.zip
