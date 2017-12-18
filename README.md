# Open Development Environment: Devbox

* Development branch: [![Build Status](https://travis-ci.org/ferrarimarco/open-development-environment-devbox.svg?branch=development)](https://travis-ci.org/ferrarimarco/open-development-environment-devbox)
* Master branch: [![Build Status](https://travis-ci.org/ferrarimarco/open-development-environment-devbox.svg?branch=master)](https://travis-ci.org/ferrarimarco/open-development-environment-devbox)

A Vagrant box serving as a development machine. It's automatically built using [Packer](https://www.packer.io/) and [Ansible](https://www.ansible.com/). Read the related [blog post](http://ferrarimarco.info/blog/development/devops/configuration/2017/07/26/open-development-environment-devbox/).

Part of the [Open Development Environment Project](https://github.com/ferrarimarco/open-development-environment).

## Changelog
For a list of changes, have a look at the [changelog](CHANGELOG.md)

## Dependencies
These are the dependencies required to run the box:
- Vagrant 2.0.1+
- Virtualbox 5.1.30+

## How to Run
To use the box:

1. Install the dependencies
1. Run `vagrant init ferrarimarco/open-development-environment-devbox` to initialize a `Vagrantfile` for this box
1. Run `vagrant up`

### Credentials
There is a `vagrant` user already configured, password: `vagrant`

## What's inside the box
This "development box" is based on Ubuntu with an XFCE Desktop environment and includes the following tools, ready to be used:
- Ansible
- [Atom editor](https://atom.io/)
- [bmon](https://github.com/tgraf/bmon)
- Eclipse Neon
- Chromium browser
- curl
- Docker
- [docker-clean](https://github.com/ZZROTDesign/docker-clean)
- [Github Changelog Generator](https://github.com/skywinder/github-changelog-generator)
- Git
- Imagemagick
- Java 8 (OpenJDK)
- [Apache JMeter](http://jmeter.apache.org/)
- [Liquibase](https://github.com/ferrarimarco/docker-liquibase)
- Maven 3
- [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer): see note below
- Ruby (with [ruby-install](https://github.com/postmodern/ruby-install) and [chruby](https://github.com/postmodern/chruby))
- Nano
- Subversion

### Bash aliases
The following aliases are automatically set up during the provisioning process:
- *`changelog-generator`*: to run Github Changelog Generator
- *`git-log1`*, *`git-log2`*, *`git-log3`*: see [open-development-environment-git](https://github.com/ferrarimarco/open-development-environment-git) for details

### Oracle SQL Developer

You should first start Oracle SQL Developer manually via command line (`/opt/oracle/sqldeveloper/sqldeveloper.sh`) because it needs to run the first setup. The default JDK is in `/usr/lib/jvm/java-8-openjdk-amd64/`.

## Example Vagrantfile

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ferrarimarco/open-development-environment-devbox"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpus", 4]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--memory", 4096]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--vram", "128"] # 10 MB is the minimum to enable Virtualbox seamless mode
    v.customize ["modifyvm", :id, "--cableconnected1", "on"] # ensure that the network cable is connected. See chef/bento#688

    # Display the VirtualBox GUI
    v.gui = true
  end
end
```

## Contributions
If you have suggestions, please create a new GitHub issue or pull request.

## Manual Build

### Dependencies
- GNU Make 4.1+
- Packer 1.1.3+
- Vagrant 2.0.1+
- Virtualbox 5.1.30+

### Build
1. Install the dependencies
1. Clone the repository
1. Run `make`

## Testing

### Dependencies
- Bundler 1.13.0+
- Ruby 2.3.0+
- Docker 1.12.0+
- See [`Gemfile`](Gemfile)

### Setup
1. Install the necessary tools: [`test/scripts/ci/before-install.sh`](test/scripts/ci/before-install.sh)
1. Install required gems from inside the root of the project: [`test/scripts/ci/install.sh`](test/scripts/ci/install.sh)
1. Run tests: [`test/scripts/ci/script.sh`](test/scripts/ci/test-role.sh)

Note that after installing the required gems you can run other Test-kitchen commands besides the ones listed in [`test/scripts/ci/script.sh`](test/scripts/ci/script.sh).
