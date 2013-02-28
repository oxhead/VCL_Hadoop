#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

list=
cmd=
user=
src=
dest=
dir=0

function usage
{
    echo "usage: cluster_scp [-l list] [-u user] [-s src] [-d dest] [-r] [-h]"
}

function execute_cmd
{
while read LINE
do

node=$(echo $LINE | cut -d, -f1)
host=$(echo $LINE | cut -d, -f2)
ip=$(echo $LINE | cut -d, -f3)

if [ ${dir} == 1 ]
then
	CMD="scp -r ${src} $user@$ip:${dest}"
else
	CMD="scp ${src} $user@$ip:${dest}"
fi

echo $CMD

#(
eval $CMD
#) 2>&1 &

done < ${list} 
}

###### main

while [ "$1" != "" ]; do
    case $1 in
	-s | --src )		shift
				src=$1
				;;
	-d | --dest )		shift
				dest=$1
				;;
	-r | --dir )		shift
				dir=1;
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

