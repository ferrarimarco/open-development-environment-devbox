all: validate clean build install upload clean clean-all

validate:
	packer validate ubuntu-100-provision-install-ansible.json
	packer validate -var 'ansible_playbook_suffix=000-prerequisites' -var 'source_path_step=provision-install-ansible' ubuntu-200-provision-ansible.json
	packer validate -var 'ansible_playbook_suffix=100-desktop' -var 'source_path_step=provision-ansible' -var 'source_path_substep=000-prerequisites' ubuntu-200-provision-ansible.json
	packer validate -var 'ansible_playbook_suffix=200-docker' -var 'source_path_substep=100-desktop' ubuntu-200-provision-ansible.json
	packer validate -var 'ansible_playbook_suffix=300-java' -var 'source_path_substep=200-docker' ubuntu-200-provision-ansible.json
	packer validate -var 'ansible_playbook_suffix=400-ruby' -var 'source_path_substep=300-java' ubuntu-200-provision-ansible.json
	packer validate -var 'ansible_playbook_suffix=500-virtualization' -var 'source_path_substep=400-ruby' ubuntu-200-provision-ansible.json
	packer validate -var 'ansible_playbook_suffix=600-general-development-tools' -var 'source_path_substep=500-virtualization' ubuntu-200-provision-ansible.json
	packer validate ubuntu-300-provision-cleanup.json
	packer validate ubuntu-400-vagrant-box.json
	packer validate ubuntu-500-vagrant-cloud-upload.json

build:
	ubuntu-000-os-install.sh
	packer build ubuntu-100-provision-install-ansible.json
	packer build -var 'ansible_playbook_suffix=000-prerequisites' -var 'source_path_step=provision-install-ansible' ubuntu-200-provision-ansible.json
	packer build -var 'ansible_playbook_suffix=100-desktop' -var 'source_path_substep=000-prerequisites' ubuntu-200-provision-ansible.json
	packer build -var 'ansible_playbook_suffix=200-docker' -var 'source_path_substep=100-desktop' ubuntu-200-provision-ansible.json
	packer build -var 'ansible_playbook_suffix=300-java' -var 'source_path_substep=200-docker' ubuntu-200-provision-ansible.json
	packer build -var 'ansible_playbook_suffix=400-ruby' -var 'source_path_substep=300-java' ubuntu-200-provision-ansible.json
	packer build -var 'ansible_playbook_suffix=500-virtualization' -var 'source_path_substep=400-ruby' ubuntu-200-provision-ansible.json
	packer build -var 'ansible_playbook_suffix=600-general-development-tools' -var 'source_path_substep=500-virtualization' ubuntu-200-provision-ansible.json
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
