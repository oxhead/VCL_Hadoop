#!/bin/bash

number=10
size=1GB


function usage
{
    echo "usage: batch [[[-n jobs ] [-s sizes]] | [-h]]"
}


function submit_jobs
{
for (( i=1; i<=${number}; i++ ))
do

(
    echo "Terasort ${i}: ${size}"
    bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar terasort /terasort/input_${size} /terasort/output_${size}_${i}
) 2>&1 &

done
}

###### main

while [ "$1" != "" ]; do
    case $1 in
        -n | --number )        shift
                                number=$1
                                ;;
        -s | --size )           shift
                                size=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

submit_jobs
