#!/bin/sh -eu

ROLE_FILE_PATH=provisioning/ansible/requirements.yml
echo "Test Ansible role installation from $ROLE_FILE_PATH"
ansible-galaxy install -r "$ROLE_FILE_PATH"

# Disable this check until we have a feedback on https://github.com/hashicorp/packer/issues/5727
#VAGRANT_CLOUD_TOKEN=dummy_token ./packer/packer validate ubuntu.json

kitchen test
