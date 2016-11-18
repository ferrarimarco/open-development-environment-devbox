# Open Development Environment: Devbox

A virtual machine serving as a development box. It's automatically built using [Vagrant](https://www.vagrantup.com/) and [Ansible](https://www.ansible.com/).

Part of the [Open Development Environment Project](https://github.com/ferrarimarco/open-development-environment).

## Changelog
For a list of changes, have a look at the [changelog](CHANGELOG.md)

## Dependencies
These are the dependencies required to run and, if you choose so, to build the box by yourself.
- Vagrant 1.8.6
- Virtualbox 5.1.6

## How to Run
You have two ways to use this virtual machine: using the prebuilt box or building by yourself.
If in doubt, just pick the prebuilt box.

## Prebuilt box
Just use `ferrarimarco/open-development-environment-devbox` in your Vagrantfile:

`config.vm.box='ferrarimarco/open-development-environment-devbox'`

## Build the box
1. Install the dependencies
1. Clone this repository
1. Run `vagrant up` from inside the cloned repository directory

The build process can take up to 15 minutes.

## What's inside the box
This "development box" is based on Ubuntu 16.04 with an XFCE Desktop environment and includes the following tools, ready to be used:
- Eclipse Neon
- Chromium browser
- curl
- git
- Nano
- Subversion

If you have suggestions about tools to include, please create a new GitHub issue.
