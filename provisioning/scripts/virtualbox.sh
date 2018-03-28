#!/bin/sh -eux

SSH_USER="${SSH_USERNAME:-vagrant}"
SSH_USER_HOME="${SSH_USER_HOME:-/home/${SSH_USER}}"

case "$PACKER_BUILDER_TYPE" in
virtualbox-iso|virtualbox-ovf)
    echo "==> Installing VirtualBox guest additions"
    VER=$(cat "$SSH_USER_HOME"/.vbox_version)
    ISO="VBoxGuestAdditions_$VER.iso";
    MOUNT_PATH="/tmp/vbox"
    mkdir -p "$MOUNT_PATH";
    mount -o loop" $SSH_USER_HOME/$ISO" "$MOUNT_PATH";
    sh "$MOUNT_PATH"/VBoxLinuxAdditions.run \
        || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
            "For more read https://www.virtualbox.org/ticket/12479";
    umount "$MOUNT_PATH";
    rm -rf "$MOUNT_PATH";
    rm -f "$SSH_USER_HOME"/*.iso;
    ;;
esac
