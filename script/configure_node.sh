#! /bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

# Configure networking & firewell
. ${script_dir}/generate_hosts.sh
sudo iptables -I ufw-before-input 1 -i eth0 -j ACCEPT
sudo iptables -I ufw-before-input 2 -i eth1 -j ACCEPT

# Configure SSH
sudo echo "ListenAddress 127.0.0.1" | sudo tee -a /etc/ssh/sshd_config
sudo service ssh restart
