#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

(
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub ${node_user}@${host}
scp -r * ${node_user}@${ip}:~/ > /dev/null

    if [ $node == "master" ]
    then
	echo "Deploy to master node: ${host}"
	ssh ${node_user}@${ip} "bash script/deploy_node_master.sh"
    else
	echo "Deploy to slave node: ${host}"
	ssh ${node_user}@${ip} "bash script/deploy_node_slave.sh"
    fi
) 2>&1 >> log/${ip}.log &
done < ${template_cluster_node_list}
