#! /bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

# [0] Configure host resolution
sudo sh -c "cat ${target_dir}/hosts >> /etc/hosts"

# [1] Configure node
. ${script_dir}/configure_node.sh

# [2] Copy application configuration files
# [2-1] Ganglia
sudo rm -rf ${conf_hadoop_dir}/*
sudo cp -r ${target_dir}/hadoop/* ${conf_hadoop_dir}
sudo cp ${target_node_ganglia_monitor} ${conf_ganglia_monitor}
sudo cp ${target_node_ganglia_meta} ${conf_ganglia_meta}
sudo service ganglia-monitor restart
sudo service gmetad restart

# [2-2] Ceph
# sudo cp ${target_node_ceph} ${conf_ceph}
