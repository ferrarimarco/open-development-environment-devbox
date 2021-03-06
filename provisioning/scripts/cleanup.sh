#!/bin/sh -eux

# From https://github.com/chef/bento/blob/master/ubuntu/scripts/cleanup.sh
# From https://github.com/boxcutter/ubuntu/blob/master/script/cleanup.sh

SSH_USER="${SSH_USERNAME:-vagrant}"
DISK_USAGE_BEFORE_CLEANUP=$(df -h)

# Make sure udev does not block our network - http://6.ptmc.org/?p=164
echo "==> Cleaning up udev rules"
rm -rf /dev/.udev/
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules

echo "==> Cleaning up leftover dhcp leases"
if [ -d "/var/lib/dhcp" ]; then
    rm -f /var/lib/dhcp/*
fi

echo "==> Current kernel version: $(uname -r)"

echo "==> Delete all Linux headers except the running kernel ones"
dpkg --list \
  | awk '{ print $2 }' \
  | grep 'linux-headers-.*-generic' \
  | grep -v "linux-headers-generic" \
  | grep -v "$(uname -r)" \
  | xargs apt-get -y purge;

# Remove specific Linux kernels, such as linux-image-3.11.0-15-generic but
# keeps the current kernel and does not touch the virtual packages,
# e.g. 'linux-image-generic', etc.
echo "==> Remove old Linux kernels"
dpkg --list \
    | awk '{ print $2 }' \
    | grep 'linux-image-.*-generic' \
    | grep -v "linux-image-generic" \
    | grep -v "$(uname -r)" \
    | xargs apt-get -y purge;

echo "==> Delete Linux source"
dpkg --list \
    | awk '{ print $2 }' \
    | grep linux-source \
    | xargs apt-get -y purge;

echo "==> Delete development packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-dev$' \
    | xargs apt-get -y purge;

echo "==> Delete docs packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-doc$' \
    | xargs apt-get -y purge;

echo "==> Delete unneeded packages"
apt-get -y purge popularity-contest installation-report;

# Exlude the files we don't need w/o uninstalling linux-firmware
echo "==> Setup dpkg excludes for linux-firmware"
cat <<_EOF_ | cat >> /etc/dpkg/dpkg.cfg.d/excludes
path-exclude=/lib/firmware/*
path-exclude=/usr/share/doc/linux-firmware/*
_EOF_

echo "==> Delete the massive firmware packages"
rm -rf /lib/firmware/*
rm -rf /usr/share/doc/linux-firmware/*

echo "==> Running APT maintenance commands"
apt-get -y autoremove;
apt-get -y clean;
apt-get -y autoclean;

echo "==> Removing APT files"
find /var/lib/apt -type f -print0 | xargs -0 rm -f

echo "==> Remove installed docs"
rm -rf /usr/share/doc/*

echo "==> Remove caches"
find /var/cache -type f -exec rm -rf {} \;

echo "==> Delete any logs that have built up during the install"
find /var/log/ -name *.log -exec rm -f {} \;

echo "==> Clearing last login information"
truncate -s 0 /var/log/lastlog
truncate -s 0 /var/log/wtmp
truncate -s 0 /var/log/btmp

if [ "$ZEROING"  = "true" ] || [ "$ZEROING" = 1 ] || [ "$ZEROING" = "yes" ]; then

  echo "==> Zeroing root"
  count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
  count=$((count-1))
  dd if=/dev/zero of=/root/whitespace bs=1024 count="$count"
  rm /root/whitespace

  echo "==> Zeroing boot"
  count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
  count=$((count-1))
  dd if=/dev/zero of=/boot/whitespace bs=1024 count="$count"
  rm /boot/whitespace

  echo "==> Cleaning up tmp"
  rm -rf /tmp/*

  echo "==> Zeroing tmp"
  count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
  count=$((count-1))
  dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
  rm /tmp/whitespace

  echo '==> Clear out swap and disable until reboot'
  set +e
  swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
  case "$?" in
      2|0) ;;
      *) exit 1 ;;
  esac
  set -e
  if [ "x${swapuuid}" != "x" ]; then
      # Whiteout the swap partition to reduce box size
      # Swap is disabled till reboot
      swappart=$(readlink -f /dev/disk/by-uuid/"$swapuuid")
      /sbin/swapoff "${swappart}"
      dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
      /sbin/mkswap -U "${swapuuid}" "${swappart}"
  fi

  echo '==> Zeroing the free space to save space in the final image'
  dd if=/dev/zero of=/EMPTY bs=1M  || echo "dd exit code $? is suppressed"
  rm -f /EMPTY

fi

echo "==> Removing Bash history"
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/"$SSH_USER"/.bash_history

# Make sure we wait until all the data is written to disk, otherwise
# Packer might quite too early before the large files are deleted
echo '==> Waiting for data to be written to disk'
sync

echo "==> Disk usage before cleanup"
echo "${DISK_USAGE_BEFORE_CLEANUP}"

echo "==> Disk usage after cleanup"
df -h

echo "==> Installed packages"
dpkg --get-selections | grep -v deinstall
