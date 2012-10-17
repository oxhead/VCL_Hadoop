#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

while read LINE
do 
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)
echo ${host}" "${ip} >> ${target_node_hosts}
done < ${template_cluster_node_list}
