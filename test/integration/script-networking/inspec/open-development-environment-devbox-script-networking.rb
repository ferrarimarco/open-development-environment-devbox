control "open-development-environment-devbox-script-networking" do
  title "open-development-environment-devbox-script-networking control"

  describe file("/etc/network/interfaces") do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0644' }
    its('content') { should match('pre-up sleep 2') }
  end

end
