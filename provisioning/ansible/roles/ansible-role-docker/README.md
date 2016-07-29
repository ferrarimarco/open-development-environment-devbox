# Ansible Role: Eclipse
[![Build Status](https://travis-ci.org/ferrarimarco/ansible-role-docker.svg?branch=master)](https://travis-ci.org/ferrarimarco/ansible-role-docker)

An Ansible role to install Docker

## Using the role
### Installation
```
ansible-galaxy install ferrarimarco.docker
```

### Example Playbook
```
  - hosts: all
    roles:
      - { role: ferrarimarco.docker, become: yes }
```
