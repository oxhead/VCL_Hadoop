#!/bin/python

import argparse


def generate_list():
	count=0
	for line in args.node_list.read().splitlines():
		count = count+1
		if count == 1:
			args.mapreduce_list.write("master,vclv99-" + line + ",152.7.99." + line + "\n")
		elif count <= args.mapreduce_num:
			args.mapreduce_list.write("slave,vclv99-" + line + ",152.7.99." + line + "\n")	
		elif count == args.mapreduce_num+1:
			args.hdfs_list.write("master,vclv99-" + line + ",152.7.99." + line + "\n")
		else:
			args.hdfs_list.write("slave,vclv99-" + line + ",152.7.99." + line + "\n")
			

parser = argparse.ArgumentParser(description='This program can generate mapreduce.list and hdfs.list from node.list, which is a ip list.')

parser.add_argument('node_list', type=file)
parser.add_argument('mapreduce_list', type=argparse.FileType('w'))
parser.add_argument('hdfs_list', type=argparse.FileType('w'))
parser.add_argument('mapreduce_num', type=int)
parser.add_argument('hdfs_num', type=int)

args = parser.parse_args()

generate_list()
