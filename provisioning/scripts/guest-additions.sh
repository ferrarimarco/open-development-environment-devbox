#!/bin/sh -eux

# From https://github.com/chef/bento/blob/master/ubuntu/scripts/cleanup.sh
# From https://github.com/boxcutter/ubuntu/blob/master/script/cleanup.sh

# set a default HOME_DIR environment variable if not set
HOME_DIR="${HOME_DIR:-/home/vagrant}";
echo "==> Home directory: $HOME_DIR"

echo "==> Install the necessary packages"
apt-get -y update
apt-get -y install dkms linux-headers-"$(uname -r)"

case "$PACKER_BUILDER_TYPE" in
virtualbox-iso|virtualbox-ovf)
    VER="$(cat "$HOME_DIR/.vbox_version")";
    echo "==> Virtualbox Version is: $VER"
    ISO="VBoxGuestAdditions_$VER.iso";
    echo "==> Virtualbox Guest Additions ISO file name is: $ISO"
    mkdir -p /tmp/vbox;
    mount -o loop "$HOME_DIR"/"$ISO" /tmp/vbox;
    sh /tmp/vbox/VBoxLinuxAdditions.run \
        || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
            "For more read https://www.virtualbox.org/ticket/12479";
    umount /tmp/vbox;
    rm -rf /tmp/vbox;
    rm -f "$HOME_DIR"/*.iso;
    ;;
esac
