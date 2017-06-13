control "open-development-environment-devbox-script-vagrant" do
  title "open-development-environment-devbox-script-vagrant control"

  user="vagrant"

  describe user(user) do
    it { should exist }
    its('group') { should eq user }
    its('groups') { should eq [user, 'sudo']}
    its('home') { should eq '/home/' + user }
  end

  describe file("/etc/sudoers.d/" + user) do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0440' }
    its('content') { should match(user + "        ALL=(ALL)       NOPASSWD: ALL\n") }
  end

  describe file("/root/.profile") do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('root') }
    its('mode') { should cmp '0644' }
    its('content') { should match("mesg n") }
    its('content') { should_not match("tty -s \&\& mesg n") }
  end

  describe file("/home/" + user + "/.ssh/authorized_keys") do
    it { should exist }
    it { should be_owned_by user }
    it { should be_grouped_into user }
    it { should be_readable.by_user(user) }
    its('mode') { should cmp '0600' }
    its('content') { should match("ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key\n") }
  end

  describe directory("/home/" + user + "/.ssh") do
    it { should exist }
    it { should be_owned_by user }
    it { should be_grouped_into user }
    it { should be_readable.by_user(user) }
    its('mode') { should cmp '0700' }
  end
end
