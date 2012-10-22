#! /bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

# Configure networking & firewell
. ${script_dir}/generate_hosts.sh
#sudo iptables -I ufw-before-input 1 -i eth0 -j ACCEPT
#sudo iptables -I ufw-before-input 2 -i eth1 -j ACCEPT
sudo ufw disable

# Configure SSH
sudo bash -c "cat /etc/ssh/sshd_config | sed 's,AllowUsers .*,AllowUsers *,g' | sed 's,PermitRootLogin no,PermitRootLogin yes,g' | sed 's,PermitEmptyPasswords no,PermitEmptyPasswords yes,g' > /tmp/sshd_config"
sudo bash -c "echo 'ListenAddress 127.0.0.1' >> /tmp/sshd_config"
sudo cp /tmp/sshd_config /etc/ssh/sshd_config

sudo bash -c "cat /etc/ssh/external_sshd_config | sed 's,AllowUsers .*,AllowUsers *,g' | sed 's,PermitRootLogin no,PermitRootLogin yes,g' | sed 's,PermitEmptyPasswords no,PermitEmptyPasswords yes,g' > /tmp/external_sshd_config"
sudo cp /tmp/external_sshd_config /etc/ssh/external_sshd_config

sudo service ssh restart
sudo service ext_sshd restart

