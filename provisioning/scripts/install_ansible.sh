#!/bin/sh

if which ansible ; then
  echo "Ansible is already installed"
else
  echo "Installing Ansible..."
  apt-get update
  apt-get install --yes software-properties-common
  add-apt-repository -y ppa:ansible/ansible
  apt-get update
  apt-get install --yes ansible
fi
