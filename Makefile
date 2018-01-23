all: validate clean build install upload clean clean-all

validate:
	packer validate ubuntu.json

build:
	packer build -only=os-install ubuntu.json
	packer build -only=provision-install-ansible ubuntu.json
	packer build -only=provision-ansible ubuntu.json
	packer build -only=provision-cleanup ubuntu.json
	packer build -only=vagrant-box ubuntu.json

clean:
	rm -rf builds

clean-all: clean
	rm -rf packer_cache

install:
	vagrant box add ferrarimarco/open-development-environment-devbox ./builds/vagrant/ubuntu-17.10.1-amd64.virtualbox.box --force || true
	vagrant box list | grep ferrarimarco/open-development-environment-devbox
	@echo Boxes have been installed. Run make clean-all to reclaim disk space.

upload:
	packer build -only=vagrant-cloud-upload ubuntu.json
