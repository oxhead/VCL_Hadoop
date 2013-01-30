#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

cluster_mapreduce_list=$1
cluster_hdfs_list=$2
cluster_combine_list=/tmp/node.list
cluster_hosts_list=/tmp/hosts.list
rm -f ${cluster_hosts_list}
rm -f ${cluster_combine_list}
touch ${cluster_hosts_list}
touch ${cluster_combine_list}
cmd="cat ${cluster_mapreduce_list} ${cluster_hdfs_list} > ${cluster_combine_list}"
eval ${cmd}
while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    echo "${ip}	${host}.hpc.csc.ncsu.edu" >> ${cluster_hosts_list}

done < ${cluster_combine_list}


while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    target=${target_dir}/${ip}
    mkdir -p ${target}
    cp ${cluster_hosts_list} ${target}/hosts

done < ${cluster_combine_list}
