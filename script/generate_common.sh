#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

cluster_node_list=$1

cluster_master_ip=`cat ${cluster_node_list} | grep master | cut -d, -f3`

tmp_slaves=/tmp/slaves
rm -f ${tmp_slaves}

while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    target=${target_dir}/${ip}
    mkdir -p ${target}

    cat ${template_node_hadoop_core} | sed "s/{cluster_master_ip}/${cluster_master_ip}/g" > ${target_node_hadoop_core}
    cat ${template_node_hadoop_script} | sed "s,{library_jdk_home},${library_jdk_home},g" > ${target_node_hadoop_script}
    cp ${template_node_hadoop_log} ${target_node_hadoop_log}

done < ${cluster_node_list}
