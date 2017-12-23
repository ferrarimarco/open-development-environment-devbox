#!/bin/sh -eux

# Disable this check until we have a feedback on https://github.com/hashicorp/packer/issues/5727
#VAGRANT_CLOUD_TOKEN=dummy_token ./packer/packer validate ubuntu.json

kitchen diagnose --all

kitchen test
