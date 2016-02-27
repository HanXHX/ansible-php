# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms = [
    [ "jessie-php-5.6", "debian/contrib-jessie64", "192.168.33.88", "php-5.6" ],
    [ "jessie-php-7.0", "debian/contrib-jessie64", "192.168.33.89", "php-7.0" ],
    [ "stretch-php-5.6", "sharlak/debian_stretch_64", "192.168.33.90", "php-5.6" ],
    [ "stretch-php-7.0", "sharlak/debian_stretch_64", "192.168.33.91", "php-7.0" ]
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
        ansible.groups = { vm[3] => [ vm[0] ] }
        ansible.verbose = 'vv'
				ansible.sudo = true
      end
    end
  end
end
