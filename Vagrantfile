# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms_debian = [
    { :name => "debian-stretch-php70", :box => "debian/stretch64", :vars => { }},
    { :name => "debian-stretch-php71", :box => "debian/stretch64", :vars => { "php_version": '7.1' }},
    { :name => "debian-stretch-php72", :box => "debian/stretch64", :vars => { "php_version": '7.2' }},
    { :name => "debian-stretch-php73", :box => "debian/stretch64", :vars => { "php_version": '7.3' }},
    { :name => "ubuntu-xenial-php70",  :box => "ubuntu/xenial64",  :vars => { }},
    { :name => "ubuntu-bionic-php72",  :box => "ubuntu/bionic64",  :vars => { }},
  ]

  vms_freebsd = [
    { :name => "freebsd-11", :box => "freebsd/FreeBSD-11.1-STABLE",  :vars => {} },
    { :name => "freebsd-12", :box => "freebsd/FreeBSD-12.0-CURRENT", :vars => {} }
  ]

  conts = [
    { :name => "docker-debian-stretch-php70", :docker => "hanxhx/vagrant-ansible:debian9",     :vars => { }},
    { :name => "docker-debian-stretch-php71", :docker => "hanxhx/vagrant-ansible:debian9",     :vars => { "php_version": '7.1' }},
    { :name => "docker-debian-stretch-php72", :docker => "hanxhx/vagrant-ansible:debian9",     :vars => { "php_version": '7.2' }},
    { :name => "docker-debian-stretch-php73", :docker => "hanxhx/vagrant-ansible:debian9",     :vars => { "php_version": '7.3' }},
    { :name => "docker-ubuntu-xenial-php70",  :docker => "hanxhx/vagrant-ansible:ubuntu16.04", :vars => { }},
    { :name => "docker-ubuntu-bionic-php72",  :docker => "hanxhx/vagrant-ansible:ubuntu18.04", :vars => { }},
  ]

  config.vm.network "private_network", type: "dhcp"

  conts.each do |opts|
    config.vm.define opts[:name] do |m|
      m.vm.provider "docker" do |d|
        d.image = opts[:docker]
        d.remains_running = true
        d.has_ssh = true
      end
      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars]
      end
    end
  end

  vms_debian.each do |opts|
    config.vm.define opts[:name] do |m|
      m.vm.box = opts[:box]
      m.vm.provider "virtualbox" do |v|
        v.cpus = 1
        v.memory = 256
      end
      m.vm.provision "shell", inline: "apt-get update && apt-get install -y ifupdown python"
      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars]
      end
    end
  end

  vms_freebsd.each do |opts|
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.base_mac = "080027D14C66"
    config.vm.define opts[:name] do |m|
      m.vm.box = opts[:box]
      m.vm.provider "virtualbox" do |v, override|
        override.ssh.shell = "csh"
        v.cpus = 2
        v.memory = 512
      end
      m.vm.provision "shell", inline: "pkg install -y python bash"
      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars].merge({ "ansible_python_interpreter": '/usr/local/bin/python' })
      end
    end
  end

end
