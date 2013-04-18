#! /bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

host=${1}
sudo hostname ${host}

# Configure networking & firewell
sudo ufw disable

# Configure SSH
sudo bash -c "cat /etc/ssh/sshd_config | sed 's,AllowUsers .*,AllowUsers *,g' | sed 's,PermitRootLogin no,PermitRootLogin yes,g' | sed 's,PermitEmptyPasswords no,PermitEmptyPasswords yes,g' > /tmp/sshd_config"
sudo bash -c "echo 'ListenAddress 127.0.0.1' >> /tmp/sshd_config"
sudo cp /tmp/sshd_config /etc/ssh/sshd_config

sudo bash -c "cat /etc/ssh/external_sshd_config | sed 's,AllowUsers .*,AllowUsers *,g' | sed 's,PermitRootLogin no,PermitRootLogin yes,g' | sed 's,PermitEmptyPasswords no,PermitEmptyPasswords yes,g' > /tmp/external_sshd_config"
sudo cp /tmp/external_sshd_config /etc/ssh/external_sshd_config

sudo service ssh restart
sudo service ext_sshd restart

