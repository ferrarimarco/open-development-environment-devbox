control "open-development-environment-devbox-ansible-playbook-600-general-development-tools" do
  title "open-development-environment-devbox-ansible-playbook-600-general-development-tools control"



  packages = [
    'python-pip',
    'python3-pip'
  ]

  packages.each do |item|
    describe package(item) do
      it { should be_installed }
    end
  end

  pip_packages = [
    { name: 'cookiecutter', version: '1.6.0' },
    { name: 'pip', version: '9.0.1' },
    { name: 'sqlparse', version: '0.2.4' }
  ]

  pip_packages.each do |item|
    package_name = "#{item[:name]}"
    package_version = "#{item[:version]}"
    describe pip(package_name) do
      it { should be_installed }
      its('version') { should eq package_version }
    end
  end

  describe file('/home/vagrant/.sqldeveloper/17.4.1/product.conf') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'vagrant' }
    it { should be_grouped_into 'vagrant' }
    it { should be_readable.by_user('vagrant') }
  end
end
