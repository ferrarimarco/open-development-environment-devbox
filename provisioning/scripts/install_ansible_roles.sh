#!/bin/sh

echo "Installing Ansible roles..."
# Install required roles
ansible-galaxy install geerlingguy.java
ansible-galaxy install ferrarimarco.atom
ansible-galaxy install ferrarimarco.docker
ansible-galaxy install ferrarimarco.ruby
