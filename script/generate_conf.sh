#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

cluster_user=$1
cluster_mapreduce_list=$2
cluster_hdfs_list=$3

. ${script_dir}/generate_hosts.sh ${cluster_mapreduce_list} ${cluster_hdfs_list}
. ${script_dir}/generate_hadoop.sh ${cluster_mapreduce_list} ${cluster_hdfs_list}
. ${script_dir}/generate_ganglia.sh MapReduce ${cluster_user} ${cluster_mapreduce_list}
. ${script_dir}/generate_ganglia.sh HDFS ${cluster_user} ${cluster_hdfs_list}
