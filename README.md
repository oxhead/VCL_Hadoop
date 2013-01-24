VCL_Hadoop
==========

**************************************
* Deploy Hadoop to NCSU VCL          *
**************************************

1) Setup SSH keys for the following deployment (from your local machine to VCL machines)

   - Format : bash script/deploy_key.sh [uid] node.list
   - Example: bash script/deploy_key.sh chsu6 template/mapreduce.list
   - Example: bash script/deploy_key.sh chsu6 template/hdfs.list

2) Generate necessay configurations

   - Format : bash script/generate_conf.sh [uid] mapreduce.list hdfs.list
   - Example: bash script/generate_conf.sh chsu6 template/mapreduce.list template/hdfs.list

3) Deploy the generated configuration to VCL machines

   - Format : bash script/deploy.sh [uid] node.list
   - Example: bash script/deploy.sh chsu6 template/ndoe.list.hadoop
   - Example: bash script/deploy.sh chsu6 template/node.list.hdfs


**************************************
* Prepare Hadoop service             *
**************************************
1) Change directory to /opt/hadoop
2) Format HDFS
   - bin/hdfs namenode -format
3) Start HDFS
   - sbin/start-dfs.sh
4) Start MapReduce
   - sbin/start-yarn.sh

**************************************
* Hadoop Monitoring                  *
**************************************
1) Application History
   - http://host:8088/
2) Node Manager
   - http://host:8042/
3) Ganglia
   - http://host/ganglia/
