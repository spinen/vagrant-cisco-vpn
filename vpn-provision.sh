#!/bin/bash

apt-get install -y vpnc vim

VPNSETTINGS=$(cat <<EOF
IPSec gateway <gateway_address>
IPSec ID <ipsec_id>
IPSec secret <shared_secret>
#IKE Authmode hybrid
Xauth username <username>
Xauth password <password>
EOF
)

#disconnect the VPN if running
vpnc-disconnect


echo "${VPNSETTINGS}" > /etc/vpnc/default.conf

#connect with our current settings
vpnc

# Iptables rules to nat the traffic
iptables-restore < /vagrant/scripts/iptables.rules