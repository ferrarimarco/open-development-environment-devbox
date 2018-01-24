all: validate clean build install upload clean clean-all

validate:
	packer validate ubuntu-000-os-install.json
	packer validate ubuntu-100-provision-install-ansible.json
	packer validate ubuntu-200-provision-ansible.json
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
