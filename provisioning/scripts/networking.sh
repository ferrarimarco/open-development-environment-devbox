#!/bin/sh -eux

ubuntu_version="`lsb_release -r | awk '{print $2}'`";
major_version="`echo $ubuntu_version | awk -F. '{print $1}'`";

echo "==> Add delay to prevent vagrant reload from failing"
echo "pre-up sleep 2" >>/etc/network/interfaces;
