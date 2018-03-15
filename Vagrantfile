Vagrant.configure("2") do |config|
  config.vm.box = "ferrarimarco/open-development-environment-devbox"

  config.vm.synced_folder File.join(Dir.home, ".ssh"), "/home/vagrant/.ssh", mount_options: ["fmode=400"]

  config.vm.provision "file", source: File.join(Dir.home, ".gitconfig"), destination: "/home/vagrant/.gitconfig"

  host = RbConfig::CONFIG['host_os']

  # Give VM 1/4 system memory
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i
    # sysctl returns Bytes and we need to convert to MB
    mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024
  elsif host =~ /linux/
    cpus = `nproc`.to_i
    # meminfo shows KB and we need to convert to MB
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
  elsif host =~ /mswin|mingw|cygwin/
    # Windows code via https://github.com/rdsubhas/vagrant-faster
    cpus = `wmic cpu Get NumberOfCores`.split[1].to_i
    mem = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024 / 1024
  end

  # Give VM 1/4 system memory & access to half of cpu cores on the host
  cpus = cpus / 2 if cpus > 1
  mem  = mem / 4  if mem > 2048

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpus", cpus]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--vram", "128"] # 10 MB is the minimum to enable Virtualbox seamless mode

    # Display the VirtualBox GUI
    v.gui = true
  end
end
