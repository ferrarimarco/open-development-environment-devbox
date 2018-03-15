Vagrant.configure("2") do |config|
  config.vm.box = "ferrarimarco/open-development-environment-devbox"

  config.vm.synced_folder File.join(Dir.home, ".ssh"), "/home/vagrant/.ssh", mount_options: ["fmode=400"]

  config.vm.provision "file", source: File.join(Dir.home, ".gitconfig"), destination: "/home/vagrant/.gitconfig"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpus", 4]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--memory", 4096]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--vram", "128"] # 10 MB is the minimum to enable Virtualbox seamless mode

    # Display the VirtualBox GUI
    v.gui = true
  end
end
