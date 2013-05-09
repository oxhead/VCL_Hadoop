#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

file=
user=


function usage
{
    echo "usage: deploy_hadoop_dist [-f file]"
}

function deploy
{
    hadoop_file=$1
    node_list=$2
    while read LINE
    do

        node=$(echo $LINE | cut -d, -f1)
        host=$(echo $LINE | cut -d, -f2)
        ip=$(echo $LINE | cut -d, -f3)

        echo "Deply Hadoop distribution to node: $ip"
        scp $file "$user@$ip:/tmp/mydoop.tar.gz"
	0</dev/null ssh $user@$ip "sudo rm -rf /opt/hadoop && sudo rm -rf /opt/mydoop && sudo mkdir /opt/mydoop && sudo tar zxvf /tmp/mydoop.tar.gz -C /opt/mydoop --strip 1 && sudo mkdir /opt/mydoop/conf && sudo ln -s /opt/mydoop /opt/hadoop && sudo chown -R ${user}:vcl /opt/mydoop"
        #0</dev/null ssh $user@$ip "sudo rm -rf /opt/hadoop"
        #0</dev/null ssh $user@$ip "sudo rm -rf /opt/mydoop"
        #0</dev/null ssh $user@$ip "sudo mkdir /opt/mydoop"
        #0</dev/null ssh $user@$ip "sudo tar zxvf /tmp/mydoop.tar.gz -C /opt/mydoop --strip 1"
        #0</dev/null ssh $user@$ip "sudo mkdir /opt/mydoop/conf"
        #0</dev/null ssh $user@$ip "sudo ln -s /opt/mydoop /opt/hadoop"
	#0</dev/null ssh $user@$ip "sudo chown -R ${user}:vcl /opt/mydoop"
        echo "Finish node delopyment: $ip"

    done < ${node_list}
}

function execute_cmd
{
    deploy $file "template/mapreduce.list.demo"
    deploy $file "template/hdfs.list.demo"

    execute_configure
}

function execute_configure
{
    echo "Start to deploy configuration..."
    rm -rf conf/*
    bash script/generate_conf.sh ${user} template/mapreduce.list.demo template/hdfs.list.demo
    bash script/deploy.sh ${user} template/mapreduce.list.demo
    bash script/deploy.sh ${user} template/hdfs.list.demo
}


###### main

while [ "$1" != "" ]; do
    case $1 in
	-f | --file )		shift
				file=$1
				;;
	-u | --user )		shift
				user=$1
				;;
	-c | --configure )	shift
				execute_configure
				exit
				;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

execute_cmd
