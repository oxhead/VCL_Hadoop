#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

list=
cmd=
user=

function usage
{
    echo "usage: hadoop_cmd [[[-f file ] [-i]] | [-h]]"
}

function execute_cmd
{
while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

CMD="ssh $user@$ip $cmd"
echo $CMD

(
eval $CMD
) 2>&1 &

done < ${list} 
}

###### main

while [ "$1" != "" ]; do
    case $1 in
        -c | --command )        shift
                                cmd=$1
                                ;;
        -l | --list )           shift
				list=$1
                                ;;
        -u | --user )           shift
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

