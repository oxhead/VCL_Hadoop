#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

cluster_mapreduce_list=$1
cluster_hdfs_list=$2
cluster_combine_list=/tmp/node.list
rm -f ${cluster_combine_list}
cat ${cluster_mapreduce_list} >> ${cluster_combine_list}
cat ${cluster_hdfs_list} >> ${cluster_combine_list}

# 1) Generage configuration files
mapreduce_master_ip=`cat ${cluster_mapreduce_list} | grep master | cut -d, -f3`
hdfs_master_ip=`cat ${cluster_hdfs_list} | grep master | cut -d, -f3`
tmp_conf_core=/tmp/core-site.xml
tmp_conf_yarn=/tmp/yarn-site.xml
tmp_conf_hdfs=/tmp/hdfs-site.xml
tmp_conf_mapred=/tmp/mapred-site.xml
tmp_conf_hadoop_script=/tmp/hadoop-env.sh
tmp_conf_yarn_script=/tmp/yarn-env.sh
tmp_conf_log=/tmp/log4j.properties
tmp_conf_masters_mapreduce=/tmp/masters.mapreduce
tmp_conf_slaves_mapreduce=/tmp/slaves.mapreduce
tmp_conf_masters_hdfs=/tmp/masters.hdfs
tmp_conf_slaves_hdfs=/tmp/slaves.hdfs

# 1-1) Generate core-site.xml
cat ${template_node_hadoop_core} | sed "s/{cluster_master_ip}/${hdfs_master_ip}/g" > ${tmp_conf_core}

# 1-2) Generate yarn-site.xml
cat ${template_node_hadoop_yarn} | sed "s/{cluster_master_ip}/${mapreduce_master_ip}/g" > ${tmp_conf_yarn}

# 1-3) Generate hdfs-site.xml
cp ${template_node_hadoop_hdfs} ${tmp_conf_hdfs}

# 1-4) Generate mapred-site.xml
cp ${template_node_hadoop_mapred} ${tmp_conf_mapred}

# 1-5) Generate hadoop-env.sh
cat ${template_node_hadoop_script} | sed "s,{library_jdk_home},${library_jdk_home},g" > ${tmp_conf_hadoop_script}

# 1-6) Generate yarn-env.sh
cp ${template_node_hadoop_yarn_script} ${tmp_conf_yarn_script}

# 1-7) Generate log4j.properties
cp ${template_node_hadoop_log} ${tmp_conf_log}

# 1-8) Generate masters and slaves for MapReduce
touch ${tmp_conf_masters_mapreduce}
rm -f ${tmp_conf_slaves_mapreduce}
while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    echo ${ip} >> ${tmp_conf_slaves_mapreduce}

done < ${cluster_mapreduce_list}

# 1-9) Generate masters and slaves for HDFS
touch ${tmp_conf_masters_hdfs}
rm -f ${tmp_conf_slaves_hdfs}
while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    echo ${ip} >> ${tmp_conf_slaves_hdfs}

done < ${cluster_hdfs_list}


# 2) Copy configuration files
# 2-1) Copy 1-1 ~ 1-7
while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    target=${target_dir}/${ip}/hadoop
    mkdir -p ${target}

    cp ${tmp_conf_core} ${target}
    cp ${tmp_conf_yarn} ${target}
    cp ${tmp_conf_hdfs} ${target}
    cp ${tmp_conf_mapred} ${target}
    cp ${tmp_conf_hadoop_script} ${target}
    cp ${tmp_conf_yarn_script} ${target}
    cp ${tmp_conf_log} ${target}

done < ${cluster_combine_list}

# 2_2) Copy 1-8
while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)

    target=${target_dir}/${ip}/hadoop

    cp ${tmp_conf_masters_mapreduce} ${target}/masters
    cp ${tmp_conf_slaves_mapreduce} ${target}/slaves

done < ${cluster_mapreduce_list}

# 2_3) Copy 1-9
while read LINE
do
    node=$(echo $LINE | cut -d, -f1)
    host=$(echo $LINE | cut -d, -f2)
    ip=$(echo $LINE | cut -d, -f3)
    target=${target_dir}/${ip}/hadoop
    cp ${tmp_conf_masters_hdfs} ${target}/masters
    cp ${tmp_conf_slaves_hdfs} ${target}/slaves
done < ${cluster_hdfs_list}
