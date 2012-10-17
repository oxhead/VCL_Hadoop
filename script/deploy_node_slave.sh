#! /bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

# [0] Configure node
. ${script_dir}/configure_node.sh

# [1] Generate node files
. ${script_dir}/generate_ganglia_monitor.sh
#. ${script_dir}/generate_ganglia_meta.sh 

# [2] Copy application configuration files
# [2-1] Ganglia
sudo cp ${target_node_ganglia_monitor} ${conf_ganglia_monitor}
#sudo cp ${target_node_ganglia_meta} ${conf_ganglia_meta}
sudo service ganglia-monitor restart
#sudo service gmetad restart

# [2-2] Ceph
