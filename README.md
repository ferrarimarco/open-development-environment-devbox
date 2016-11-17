# Open Development Environment: Devbox

A virtual machine serving as a development box. It's automatically built using [Vagrant](https://www.vagrantup.com/) and [Ansible](https://www.ansible.com/).

Part of the [Open Development Environment Project](https://github.com/ferrarimarco/open-development-environment).

## Build status
- Master Branch: [![Build Status Master Branch](https://travis-ci.org/ferrarimarco/open-development-environment-devbox.svg?branch=master)](https://travis-ci.org/ferrarimarco/open-development-environment-devbox)
- Development Branch: [![Build Status Development Branch](https://travis-ci.org/ferrarimarco/open-development-environment-devbox.svg?branch=development)](https://travis-ci.org/ferrarimarco/open-development-environment-devbox)

## Dependencies
These are the dependencies required to run and, if you choose so, to build the box by yourself.
- Vagrant 1.8.7
- Virtualbox 5.1.8

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
