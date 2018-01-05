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
This "development box" is based on Ubuntu 17.04 with an XFCE Desktop environment and includes the following tools, ready to be used:
- Ansible
- [Atom editor](https://atom.io/)
- [bmon](https://github.com/tgraf/bmon)
- Chromium browser
- curl
- Docker
- [docker-clean](https://github.com/ZZROTDesign/docker-clean)
- Docker Compose
- [Dockerlint](https://github.com/RedCoolBeans/dockerlint)
- Eclipse Neon
- [Github Changelog Generator](https://github.com/skywinder/github-changelog-generator)
- Git
- glogg
- [hadolint](https://github.com/hadolint/hadolint)
- Imagemagick
- Inspec
- Java 8 (OpenJDK)
- [JMeter](http://jmeter.apache.org/)
- libreoffice Calc
- [Liquibase](https://github.com/ferrarimarco/docker-liquibase)
- Maven 3
- Nano
- Nethogs
- [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer): see note below
- [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)
- Ruby (with [ruby-install](https://github.com/postmodern/ruby-install) and [chruby](https://github.com/postmodern/chruby))
- [Shellcheck](https://github.com/koalaman/shellcheck)
- Subversion
- Vagrant
- Virtualbox

### Bash aliases
The following aliases are automatically set up during the provisioning process:
- *`changelog-generator`*: to run Github Changelog Generator
- *`docker-clean`*: to run [docker-clean](https://github.com/ZZROTDesign/docker-clean)
- *`dockerfile-lint`*: to run [hadolint](https://github.com/hadolint/hadolint) and [dockerlint](https://github.com/RedCoolBeans/dockerlint) on every Dockerfile in the current directory and its subdirectories
- *`git-log1`*, *`git-log2`*, *`git-log3`*: see [open-development-environment-git](https://github.com/ferrarimarco/open-development-environment-git) for details
- *`psscriptanalyzer`*: to run [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) on every Powershell script in the current directory and its subdirectories
- *`shellcheck`*: to run [shellcheck](https://github.com/koalaman/shellcheck) on every shell script in the current directory and its subdirectories

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

### Manual Downloads

Due to licensing reasons, we cannot include the SQL Developer setup package. Download it manually from [Oracle Website](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html) and place it in `provisioning/downloads/` and update `sql_developer_path` value in the `variables` section of the [`template`](ubuntu.json) (or provide your own `variables` file).
