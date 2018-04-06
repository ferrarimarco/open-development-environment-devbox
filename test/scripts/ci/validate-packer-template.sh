#!/bin/sh -eu

mktouch() {
  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    touch -a -- "$f"
  done
}

# Workaround until we have feedback on https://github.com/hashicorp/packer/issues/5727
mktouch \
  ./builds/virtualbox-iso/os-install/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-install-ansible/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/000-prerequisites/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/100-desktop/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/200-docker/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/300-java/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/400-ruby/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/500-virtualization/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/provision-ansible/600-general-development-tools/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf \
  ./builds/virtualbox-ovf/upgrade/ubuntu-17.10-amd64/open-development-environment-devbox-build.ovf

# Create a dummy archive to validate its path in the template
mktouch ./provisioning/downloads/sqldeveloper-17.4.1.054.0712-no-jre.zip

VAGRANT_CLOUD_TOKEN=dummy_token make validate

rm -rf ./builds
rm ./provisioning/downloads/sqldeveloper-17.4.1.054.0712-no-jre.zip
