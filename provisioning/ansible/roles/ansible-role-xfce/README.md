# Ansible Role: Eclipse
[![Build Status](https://travis-ci.org/ferrarimarco/ansible-role-xfce.svg?branch=master)](https://travis-ci.org/ferrarimarco/ansible-role-xfce)

An Ansible role to install XFCE

## Using the role
### Installation
```
ansible-galaxy install ferrarimarco.xfce
```

### Example Playbook
```
  - hosts: all
    roles:
      - { role: ferrarimarco.xfce, become: yes }
```
