#!/bin/sh -eu

ROLE_FILE_PATH=provisioning/ansible/requirements.yml
echo "Test Ansible role installation from $ROLE_FILE_PATH"
ansible-galaxy install -r "$ROLE_FILE_PATH"
