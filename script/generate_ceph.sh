#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf


count=0

while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

    if [ $node == "slave" ]
    then
	count=$((count+1))
	echo "[osd.${count}]" >> ${target_node_ceph}
	echo "        host = ${host}" >> ${target_node_ceph}
    else
	sed "s/{cluster_master_hostname}/${cluster_master_hostname}/g" ${template_node_ceph} | sed "s/{cluster_master_ip}/${cluster_master_ip}/g" > ${target_node_ceph}
    fi

done < ${template_cluster_node_list}
