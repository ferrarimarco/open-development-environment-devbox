control "open-development-environment-devbox-ansible-playbook-200-docker" do
  title "open-development-environment-devbox-ansible-playbook-200-docker control"

  describe user('vagrant') do
    it { should exist }
    its('groups') { should eq ['vagrant', 'docker']}
  end

end
