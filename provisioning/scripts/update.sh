#!/bin/sh -eux

ubuntu_version="$(lsb_release -r | awk '{print $2}')";
major_version="$(echo "$ubuntu_version" | awk -F. '{print $1}')";

echo "==> Setting DEBIAN_FRONTEND"
export DEBIAN_FRONTEND=noninteractive

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

# Disable systemd apt timers/services
if [ "$major_version" -ge "16" ]; then
  systemctl stop apt-daily.timer;
  systemctl stop apt-daily-upgrade.timer;
  systemctl disable apt-daily.timer;
  systemctl disable apt-daily-upgrade.timer;
  systemctl mask apt-daily.service;
  systemctl mask apt-daily-upgrade.service;
  systemctl daemon-reload;
fi

# Disable periodic activities of apt
echo "==> Disable periodic activities of apt"
cat <<EOF >/etc/apt/apt.conf.d/10disable-periodic;
APT::Periodic::Enable "0";
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

# Clean and nuke the package from orbit
rm -rf /var/log/unattended-upgrades;
apt-get -y purge unattended-upgrades;

UPDATE=${UPDATE:-false}

# Upgrade all installed packages incl. kernel and kernel headers
if [ "$UPDATE"  = "true" ] || [ "$UPDATE" = 1 ] || [ "$UPDATE" = "yes" ]; then
    echo "==> Performing dist-upgrade (all packages and kernel)"
    apt-get -y dist-upgrade -o Dpkg::Options::="--force-confnew";
fi
