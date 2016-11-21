# Open Development Environment: Devbox

A virtual machine serving as a development box. It's automatically built using [Vagrant](https://www.vagrantup.com/) and [Ansible](https://www.ansible.com/).

Part of the [Open Development Environment Project](https://github.com/ferrarimarco/open-development-environment).

## Changelog
For a list of changes, have a look at the [changelog](CHANGELOG.md)

## Dependencies
These are the dependencies required to build and run the box:
- Vagrant 1.8.6
- Virtualbox 5.1.6

## How to Run
To build the box:

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
- Maven 3
- Nano
- Subversion

If you have suggestions about tools to include, please create a new GitHub issue.
