# Ansible Role: Eclipse
[![Build Status](https://travis-ci.org/ferrarimarco/ansible-role-eclipse.svg?branch=master)](https://travis-ci.org/ferrarimarco/ansible-role-eclipse)

An Ansible role to install [Eclipse](https://eclipse.org)

## Using the role
### Installation
```
ansible-galaxy install ferrarimarco.eclipse
```

### Example Playbook
```
  - hosts: all
    roles:
      - { role: ferrarimarco.eclipse, become: yes }
```
