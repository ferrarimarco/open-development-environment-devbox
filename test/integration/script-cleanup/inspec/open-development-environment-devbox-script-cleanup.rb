control "open-development-environment-devbox-script-cleanup" do
  title "open-development-environment-devbox-script-cleanup control"

  describe directory("/dev/.udev") do
    it { should_not exist }
  end

  describe file("/lib/udev/rules.d/75-persistent-net-generator.rules") do
    it { should_not exist }
  end

  describe command('dpkg --get-selections') do
   its('stdout') { should_not match('linux-headers') }
   its('stdout') { should_not match('linux-image-.*-generic') }
   its('stdout') { should_not match('linux-source') }
  end

  describe package('popularity-contest') do
    it { should_not be_installed }
  end

  describe package('installation-report') do
    it { should_not be_installed }
  end

  describe package('command-not-found') do
    it { should_not be_installed }
  end

  describe package('command-not-found-data') do
    it { should_not be_installed }
  end

  describe package('friendly-recovery') do
    it { should_not be_installed }
  end

  describe package('landscape-common') do
    it { should_not be_installed }
  end

  describe package('wireless-tools') do
    it { should_not be_installed }
  end

  describe package('wpasupplicant') do
    it { should_not be_installed }
  end

  describe package('ubuntu-serverguide') do
    it { should_not be_installed }
  end

  describe package('deborphan') do
    it { should_not be_installed }
  end

  describe package('dialog') do
    it { should_not be_installed }
  end

  describe file("/root/.bash_history") do
    it { should_not exist }
  end

  describe file("/home/vagrant/.bash_history") do
    it { should_not exist }
  end
end
