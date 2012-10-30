#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

node_user=$1
cluster_node_list=$2

while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

(
scp -r script ${node_user}@${ip}:~/ > /dev/null
scp -r conf/$ip/* ${node_user}@${ip}:~/conf > /dev/null

    if [ $node == "master" ]
    then
	echo "Deploy to master node: ${host}"
	ssh ${node_user}@${ip} "bash script/deploy_node_master.sh"
    else
	echo "Deploy to slave node: ${host}"
	ssh ${node_user}@${ip} "bash script/deploy_node_slave.sh"
    fi

) 2>&1 >> log/${ip}.log &
done < ${cluster_node_list}
