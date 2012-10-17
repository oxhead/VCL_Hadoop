#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

ssh-copy-id -i $HOME/.ssh/id_rsa.pub ${node_user}@${ip}

done < ${template_cluster_node_list}
