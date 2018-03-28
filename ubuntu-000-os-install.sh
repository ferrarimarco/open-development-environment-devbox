#!/bin/sh

box_checksum="953e83e6286a78450fa681f4d7a452e8796ddd06c5d4158e0fa192c21ebba677"
box_id="ubuntu-17.10"
box_version="201803.24.0"
destination_directory="builds/virtualbox-iso/os-install/$box_id-amd64"
org_id="bento"
provider="virtualbox"
source_directory="$HOME/.vagrant.d/boxes/$org_id-VAGRANTSLASH-$box_id/$box_version/$provider"

vagrant box add --box-version "$box_version" --provider virtualbox "$org_id"/"$box_id" 2> /dev/null || true
mkdir -p "$destination_directory"
cp -r "$source_directory" "$destination_directory"
mv "$destination_directory"/"$provider"/* "$destination_directory"
rmdir "$destination_directory"/"$provider"
mv "$destination_directory"/box.ovf "$destination_directory"/open-development-environment-devbox-build.ovf
