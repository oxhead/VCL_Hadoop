#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

mkdir -p ${target_dir}/hadoop

cat ${template_node_hadoop_core} | sed "s/{cluster_master_ip}/${cluster_master_ip}/g" > ${target_node_hadoop_core}
cat ${template_node_hadoop_yarn} | sed "s/{cluster_master_ip}/${cluster_master_ip}/g" > ${target_node_hadoop_yarn}
cat ${template_node_hadoop_script} | sed "s,{library_jdk_home},${library_jdk_home},g" > ${target_node_hadoop_script}

cp ${template_node_hadoop_hdfs} ${target_node_hadoop_hdfs}
cp ${template_node_hadoop_log} ${target_node_hadoop_log}
cp ${template_node_hadoop_yarn_script} ${target_node_hadoop_yarn_script}

while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)
    if [ $node == "master" ]
    then
        echo ${ip} >> ${target_node_hadoop_masters}
    fi
    echo ${ip} >> ${target_node_hadoop_slaves}
done < ${template_cluster_node_list}
