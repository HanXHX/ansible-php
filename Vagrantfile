# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms_debian = [
    { :name => "debian-stretch-php70", :box => "debian/stretch64", :vars => { }},
    { :name => "debian-stretch-php71", :box => "debian/stretch64", :vars => { "php_version": '7.1' }},
    { :name => "debian-stretch-php72", :box => "debian/stretch64", :vars => { "php_version": '7.2' }}
  ]

  conts = [
    { :name => "docker-debian-stretch-php70", :docker => "hanxhx/vagrant-ansible:debian9", :vars => { }},
    { :name => "docker-debian-stretch-php71", :docker => "hanxhx/vagrant-ansible:debian9", :vars => { "php_version": '7.1' }},
    { :name => "docker-debian-stretch-php72", :docker => "hanxhx/vagrant-ansible:debian9", :vars => { "php_version": '7.2' }}
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
       m.vm.provision "ansible" do |ansible|
         ansible.playbook = "tests/test.yml"
         ansible.verbose = 'vv'
         ansible.become = true
          ansible.extra_vars = opts[:vars]
       end
    end
  end
end
