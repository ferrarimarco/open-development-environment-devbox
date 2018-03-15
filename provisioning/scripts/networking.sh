#!/bin/sh -eux

ubuntu_version="$(lsb_release -r | awk '{print $2}')";

if [ "$ubuntu_version" = '17.10' ]; then
echo "==> Create netplan config for eth0"
cat <<EOF >/etc/netplan/01-netcfg.yaml;
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
EOF
else
  # Set up eth0 for pre-17.10
  echo "==> Create /etc/network/interfaces.d config for eth0"
  printf "auto eth0\\niface eth0 inet dhcp" >> /etc/network/interfaces.d/eth0.cfg
  echo "==> Add delay to prevent vagrant reload from failing"
  echo "pre-up sleep 2" >>/etc/network/interfaces;
fi

echo "==> Disable systemd Predictable Network Interface Names"
sed -ie 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 \1"/g' /etc/default/grub
update-grub
