# Vagrant-cisco-vpn box

The purpose of this repo is create a VM that can route local traffic on your mac through an exclusive VPN trunk.

## Requirements

* Update the vpn settings for the vpn default.conf in the vpn-provision.sh script.
* Update the Vagrantfile to replace ```<ip_range>``` with the ip range/cidr
