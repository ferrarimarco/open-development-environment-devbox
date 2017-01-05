# Open Development Environment: Devbox

A virtual machine serving as a development box. It's automatically built using [Vagrant](https://www.vagrantup.com/) and [Ansible](https://www.ansible.com/).

Part of the [Open Development Environment Project](https://github.com/ferrarimarco/open-development-environment).

## Changelog
For a list of changes, have a look at the [changelog](CHANGELOG.md)

## Dependencies
These are the dependencies required to build and run the box:
- Vagrant 1.8.7
- Virtualbox 5.1.10

## How to Run
To build the box:

1. Install the dependencies
1. Clone this repository
1. Run `vagrant up` from inside the cloned repository directory

The build process can take up to 15 minutes.

### Credentials
There is a `vagrant` user already configured, password: `vagrant`

## What's inside the box
This "development box" is based on Ubuntu 16.04 with an XFCE Desktop environment and includes the following tools, ready to be used:
- Eclipse Neon (avaliable in `/home/vagrant/sw`)
- Chromium browser
- curl
- Docker
- [docker-clean](https://github.com/ZZROTDesign/docker-clean)
- [Github Changelog Generator](https://github.com/skywinder/github-changelog-generator)
- Git
- Oracle SQL Developer ([see below](#how-to-install-oracle-sql-developer), avaliable in `/home/vagrant/sw`)
- Maven 3
- Nano
- Subversion

If you have suggestions about tools to include, please create a new GitHub issue.

### Bash aliases
The following aliases are automatically set up during the provisioning process:
- *`changelog-generator`*: to run Github Changelog Generator
- *`git-log1`*, *`git-log2`*, *`git-log3`*: see [open-development-environment-git](https://github.com/ferrarimarco/open-development-environment-git) for details

### How to install Oracle SQL Developer
The archive containing Oracle SQL Developer must be manually downloaded from Oracle as it requires the acceptance of a license and a login:

1. Download Oracle SQL Developer from [Oracle Website](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index-097090.html)
1. Put the downloaded archive in `provisioning/ansible/downloads`
1. Rename the archive file to `sqldeveloper.zip`
1. Run the playbook
