#!/bin/sh -eux

SSH_USER="${SSH_USERNAME:-vagrant}"
SSH_USER_HOME="${SSH_USER_HOME:-/home/${SSH_USER}}"

case "$PACKER_BUILDER_TYPE" in
virtualbox-iso|virtualbox-ovf)
    echo "==> Installing VirtualBox guest additions"
    VER=$(cat "$SSH_USER_HOME"/.vbox_version)
    ISO="VBoxGuestAdditions_$VER.iso";
    mkdir -p /tmp/vbox;
    mount -o loop" $SSH_USER_HOME/$ISO" /tmp/vbox;
    sh /tmp/vbox/VBoxLinuxAdditions.run \
        || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
            "For more read https://www.virtualbox.org/ticket/12479";
    umount /tmp/vbox;
    rm -rf /tmp/vbox;
    rm -f "$SSH_USER_HOME"/*.iso;
    ;;
esac
