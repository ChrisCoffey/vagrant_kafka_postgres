# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"  #"dev-env"
  #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-1310-x64-virtualbox-puppet.box"
  config.ssh.forward_agent = true
  config.vm.provision "shell", path: "./provision.sh"
#  config.vm.provision "file", source: "~/scripts/provision.sh", destination: "provision.sh" 
  config.vm.network "private_network", ip: "192.168.33.10", virtualbox__inet: true

  config.vm.provider "virtualbox" do |v|
    #v.gui = true
    v.memory = "2056"
  end
end
