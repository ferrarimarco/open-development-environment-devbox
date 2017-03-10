# Open Development Environment: Devbox

A virtual machine serving as a development box. It's automatically built using [Vagrant](https://www.vagrantup.com/) and [Ansible](https://www.ansible.com/).

Part of the [Open Development Environment Project](https://github.com/ferrarimarco/open-development-environment).

## Changelog
For a list of changes, have a look at the [changelog](CHANGELOG.md)

## Dependencies
These are the dependencies required to build and run the box:
- Vagrant 1.8.7+
- Virtualbox 5.1.10+

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
- Ansible
- [Atom editor](https://atom.io/)
- Eclipse Neon (avaliable in `/home/vagrant/sw`)
- Chromium browser
- curl
- Docker
- [docker-clean](https://github.com/ZZROTDesign/docker-clean)
- [Github Changelog Generator](https://github.com/skywinder/github-changelog-generator)
- Git
- Java 8 (OpenJDK)
- [Apache JMeter](http://jmeter.apache.org/)
- Maven 3
- Ruby (with [ruby-install](https://github.com/postmodern/ruby-install) and [chruby](https://github.com/postmodern/chruby))
- Nano
- Subversion

### Bash aliases
The following aliases are automatically set up during the provisioning process:
- *`changelog-generator`*: to run Github Changelog Generator
- *`git-log1`*, *`git-log2`*, *`git-log3`*: see [open-development-environment-git](https://github.com/ferrarimarco/open-development-environment-git) for details

## Contributions
If you have suggestions, please create a new GitHub issue or a pull request.
