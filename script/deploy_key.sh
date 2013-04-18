#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

#0</dev/null ssh ${1}@${ip} "sudo chown ${1}:vcl ~/.ssh/authorized_keys"
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub ${1}@${ip}
scp $HOME/.ssh/id_rsa ${1}@${ip}:~/.ssh/
scp $HOME/.ssh/id_rsa.pub ${1}@${ip}:~/.ssh/

done < ${2}
