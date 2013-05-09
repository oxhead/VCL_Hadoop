#!/bin/bash

for (( i=1; i<=10000; i++ ))
do
    bash script/repair_hostname.sh -u chsu6 -f template/mapreduce.list.demo
    bash script/repair_hostname.sh -u chsu6 -f template/hdfs.list.demo
    sleep 60
done
