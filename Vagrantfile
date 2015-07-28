#!/usr/bin/env ruby
#^syntaxBOX detection

# -*- mode: ruby -*-
# vi: set ft=ruby :

#This is a Vagrant box specifically to be use for natting SPINEN traffic over the VPN tunnel to HCS
# It will require the "vagrant-triggers" vagrant plugin. 
# When you 'vagrant up' with this Vagrantfile 

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = 'localhost-vagrant'

  eth1_ip = '172.28.100.10'
  
  config.vm.box = "chef/ubuntu-14.04"
  config.vm.box_url = "https://vagrantcloud.com/chef/ubuntu-12.04"
  # Override the configurations for the vmware_fusion
  config.vm.provider "vmware_fusion" do |vmware_fusion, override|
    # Give the vm a gig of RAM.  With the default amount, composer was choking
    vmware_fusion.vmx["memsize"] = "1024"
  end
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "#{eth1_ip}"

  # The native folder syncing is very slow, so NFS is better
  config.vm.synced_folder ".", "/vagrant", nfs: true


  config.vm.provision "shell", path: "scripts/vpn-provision.sh"

  config.trigger.after :up do
    # route all traffic for the docker ips to the vm host
    run "sudo route add <ip_range> #{eth1_ip}"
  end

  config.trigger.after [:halt, :suspend, :destroy] do
    # remove the routing when the vm host is not running
    run "sudo route delete <ip_range> #{eth1_ip}"
  end
end
