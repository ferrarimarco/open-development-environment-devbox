#!/bin/sh -eux

VAGRANT_CLOUD_TOKEN=dummy_token ./packer/packer validate ubuntu.json

kitchen diagnose --all

kitchen test
