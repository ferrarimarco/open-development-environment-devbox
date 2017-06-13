control "open-development-environment-devbox-script-update" do
  title "open-development-environment-devbox-script-update control"

  describe file("/etc/update-manager/release-upgrades") do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0644' }
    its('content') { should match('Prompt=never') }
  end

  describe file("/etc/init/refresh-apt.conf") do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0644' }
    its('content') { should match('description "update package index"\nstart on networking\ntask\n') }
  end

  describe file("/etc/apt/apt.conf.d/10disable-periodic") do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0644' }
    its('content') { should match('APT::Periodic::Enable "0";') }
  end

end
