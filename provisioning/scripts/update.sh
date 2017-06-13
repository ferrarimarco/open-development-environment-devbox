#!/bin/sh -eux

echo "==> Checking version of Ubuntu"
ubuntu_version="`lsb_release -r | awk '{print $2}'`";
ubuntu_major_version="`echo $ubuntu_version | awk -F. '{print $1}'`";

# Disable release-upgrades
echo "==> Disabling the release upgrader"
release_upgrades_directory_path="/etc/update-manager"
release_upgrades_file_path="$release_upgrades_directory_path/release-upgrades"
if [ -f "$release_upgrades_file_path" ]
then
	sed -i.bak 's/^Prompt=.*$/Prompt=never/' $release_upgrades_file_path;
else
  mkdir -p $release_upgrades_directory_path
	echo "Prompt=never" > $release_upgrades_file_path
fi

# Update the package list
echo "==> Updating list of repositories"
apt-get -y update;

# update package index on boot
echo "==> Update package index on boot"
cat <<EOF >/etc/init/refresh-apt.conf;
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

# Disable periodic activities of apt
echo "==> Disable periodic activities of apt"
cat <<EOF >/etc/apt/apt.conf.d/10disable-periodic;
APT::Periodic::Enable "0";
EOF

UPDATE=${UPDATE:-false}
REBOOT=${REBOOT:-1}

# Upgrade all installed packages incl. kernel and kernel headers
if [ $UPDATE  = "true" ] || [ $UPDATE = 1 ] || [ $UPDATE = "yes" ]; then
    echo "==> Performing dist-upgrade (all packages and kernel)"
    apt-get -y dist-upgrade --force-yes
		if [ $REBOOT  = 1 ]; then
    	reboot
			sleep 60
		fi
fi
