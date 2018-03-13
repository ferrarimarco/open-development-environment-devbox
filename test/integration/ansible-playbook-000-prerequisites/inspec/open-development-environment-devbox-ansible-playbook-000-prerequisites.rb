control "open-development-environment-devbox-ansible-playbook-000-prerequisites" do
  title "open-development-environment-devbox-ansible-playbook-000-prerequisites control"

  packages = [
    'apt-transport-https',
    'bmon',
    'bridge-utils',
    'bzip2',
    'ca-certificates',
    'chromium-browser',
    'curl',
    'git',
    'glogg',
    'gzip',
    'imagemagick',
    'jmeter',
    'language-pack-en',
    'libreoffice-calc',
    'maven',
    'nethogs',
    'subversion',
    'tar',
    'unzip'
  ]

  packages.each do |item|
    describe package(item) do
      it { should be_installed }
    end
  end

end
