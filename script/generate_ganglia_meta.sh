#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

cat ${template_node_ganglia_meta} | sed "s/{cluster_name}/${cluster_name}/g" > ${target_node_ganglia_meta}
