#!/bin/sh

echo "Installing Ansible roles..."
# Install required roles
pwd
ansible-galaxy install -r /tmp/provisioning/ansible/requirements.yml
