#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

sed "s/{cluster_master_hostname}/${cluster_master_hostname}/g" ${template_node_ganglia_monitor} | sed "s/{cluster_name}/${cluster_name}/g" > ${target_node_ganglia_monitor}
