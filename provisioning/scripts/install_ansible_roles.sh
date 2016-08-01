#!/bin/bash

echo "Installing Ansible roles..."
# Install required roles
ansible-galaxy install geerlingguy.java
ansible-galaxy install ferrarimarco.docker
