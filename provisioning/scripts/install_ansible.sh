#!/bin/sh

if which ansible ; then
  echo "Ansible is already installed"
else
  echo "Installing Ansible..."
  apt-get update
  apt-get install --yes software-properties-common
  add-apt-repository ppa:ansible/ansible
  apt-get update
  apt-get install --yes ansible=2.2.0.0-1ppa~xenial
fi
