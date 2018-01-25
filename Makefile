all: validate clean build install upload clean clean-all

validate:
	packer validate ubuntu-000-os-install.json
	packer validate ubuntu-100-provision-install-ansible.json
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=000-prerequisites' \
		-var 'source_path_step=provision-install-ansible' \
		-var 'source_path_substep=null'
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=100-desktop' \
		-var 'source_path_step=provision-ansible' \
		-var 'source_path_substep=000-prerequisites'
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=200-docker' \
		-var 'source_path_substep=100-desktop'
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=300-java' \
		-var 'source_path_substep=200-docker'
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=400-ruby' \
		-var 'source_path_substep=300-java'
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=500-virtualization' \
		-var 'source_path_substep=400-ruby'
	packer validate ubuntu-200-provision-ansible.json \
		-var 'ansible_playbook_suffix=600-general-development-tools' \
		-var 'source_path_substep=500-virtualization'
	packer validate ubuntu-300-provision-cleanup.json
	packer validate ubuntu-400-vagrant-box.json
	packer validate ubuntu-500-vagrant-cloud-upload.json

build:
	packer build ubuntu-000-os-install.json
	packer build ubuntu-100-provision-install-ansible.json
	packer build ubuntu-200-provision-ansible.json
	packer build ubuntu-300-provision-cleanup.json
	packer build ubuntu-400-vagrant-box.json

clean:
	rm -rf builds

clean-all: clean
	rm -rf packer_cache

install:
	vagrant box add ferrarimarco/open-development-environment-devbox ./builds/vagrant/ubuntu-17.10.1-amd64.virtualbox.box --force || true
	vagrant box list | grep ferrarimarco/open-development-environment-devbox

upload:
	packer build ubuntu-500-vagrant-cloud-upload.json
	@echo Box has been uploaded. Run make clean-all to reclaim disk space.
