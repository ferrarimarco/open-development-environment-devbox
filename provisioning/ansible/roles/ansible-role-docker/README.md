# Ansible Role: Eclipse
[![Build Status](https://travis-ci.org/ferrarimarco/ansible-role-devbox.svg?branch=master)](https://travis-ci.org/ferrarimarco/ansible-role-devbox)

An Ansible role to setup a development box

## Using the role
### Installation
```
ansible-galaxy install ferrarimarco.devbox
```

### Example Playbook
```
  - hosts: all
    roles:
      - { role: ferrarimarco.devbox, become: yes }
```
