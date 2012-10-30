#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

cluster_name=$1
cluster_user=$2
cluster_node_list=$3
cluster_master_ip=`cat ${cluster_node_list} | grep master | cut -d, -f3`

tmp_conf_ganglia_monitor=/tmp/gmond.conf
tmp_conf_ganglia_meta=/tmp/gmetad.conf

cat ${template_node_ganglia_monitor} | sed "s,{cluster_master_hostname},${cluster_master_ip},g" | sed "s,{cluster_name},${cluster_name},g" > ${tmp_conf_ganglia_monitor}

cat ${template_node_ganglia_meta} | sed "s,{cluster_name},${cluster_name},g" > ${tmp_conf_ganglia_meta}

while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    target=${target_dir}/${ip}
    mkdir -p ${target}

    cp ${tmp_conf_ganglia_monitor} ${target}
    cp ${tmp_conf_ganglia_meta} ${target}

done < ${cluster_node_list}
