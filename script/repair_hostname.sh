#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

function usage
{
    echo "usage: repair_hostname [-u user] [-f file]"
}

function repair
{
    user=$1
    node_list=$2
    while read LINE
    do

        node=$(echo $LINE | cut -d, -f1)
        host=$(echo $LINE | cut -d, -f2)
        ip=$(echo $LINE | cut -d, -f3)

        echo "Repair hostname on node: $ip"
	0</dev/null ssh $user@$ip "sudo hostname ${host}"

    done < ${node_list}
}

function execute_cmd
{
    repair $user $file
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
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

execute_cmd
