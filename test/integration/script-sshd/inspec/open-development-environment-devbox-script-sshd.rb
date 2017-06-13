control "open-development-environment-devbox-script-sshd" do
  title "open-development-environment-devbox-script-sshd control"

  describe file("/etc/ssh/sshd_config") do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0644' }
    its('content') { should match('UseDNS no') }
    its('content') { should match('GSSAPIAuthentication no') }
  end

end
