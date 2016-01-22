# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms = [
    [ "wheezy-php54", "deb/wheezy-amd64" , "192.168.33.87" ],
    [ "jessie-php56", "deb/jessie-amd64", "192.168.33.88" ],
    [ "jessie-php70", "deb/jessie-amd64", "192.168.33.89" ],
    [ "stretch-php56", "sharlak/debian_stretch_64", "192.168.33.90" ],
    [ "stretch-php70", "sharlak/debian_stretch_64", "192.168.33.91" ]
  ]

  config.vm.provider "virtualbox" do |v|
    v.cpus = 1
    v.memory = 256
  end

  vms.each do |vm|
    config.vm.define vm[0] do |m|
      m.vm.box = vm[1]
      m.vm.network "private_network", ip: vm[2]

      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.groups = { "test" => [ vm[0] ] }
        ansible.verbose = 'vv'
				ansible.sudo = true
      end
    end
  end
end
