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

    touch ${target}/masters
    echo ${ip} >> ${tmp_slaves}
    cp ${template_node_hadoop_hdfs} ${target}/hdfs-site.xml  

done < ${cluster_node_list}

while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    target=${target_dir}/${ip}
    cp ${tmp_slaves} ${target}/slaves

done < ${cluster_node_list}
