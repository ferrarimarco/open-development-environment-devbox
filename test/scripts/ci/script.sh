#!/bin/sh -eu

mktouch() {
  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    touch -a -- "$f"
  done
}


ROLE_FILE_PATH=provisioning/ansible/requirements.yml
echo "Test Ansible role installation from $ROLE_FILE_PATH"
ansible-galaxy install -r "$ROLE_FILE_PATH"

# Workaround until we have feedback on https://github.com/hashicorp/packer/issues/5727
mktouch \
  ./builds/virtualbox-iso/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-install-ansible/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-cleanup/ubuntu-17.10.1-amd64/open-development-environment-devbox-build.ovf

VAGRANT_CLOUD_TOKEN=dummy_token ./packer/packer validate ubuntu.json

kitchen test

rm -rf builds
