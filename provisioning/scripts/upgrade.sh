#!/bin/sh -eux

# From https://github.com/chef/bento/blob/master/ubuntu/scripts/cleanup.sh
# From https://github.com/boxcutter/ubuntu/blob/master/script/cleanup.sh

# set a default HOME_DIR environment variable if not set
CURRENT_KERNEL_VERSION="$(uname -r)"
echo "==> Current kernel version: $CURRENT_KERNEL_VERSION"

apt-get -y update
apt-get -y install linux-headers-generic linux-image-generic
apt-get -y dist-upgrade
