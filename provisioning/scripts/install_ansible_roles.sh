#!/bin/sh

echo "Installing Ansible roles..."
# Install required roles
ansible-galaxy install -r /tmp/provisioning/ansible/requirements.yml
