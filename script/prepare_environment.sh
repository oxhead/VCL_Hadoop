#!/bin/bash

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. ${script_dir}/include.conf

# [0] Create necessary files
# 1) create hosts for /etc/hosts
. ${script_dir}/generate_hosts.sh

# [1] Connection setup
# ssh-copy-id -i $HOME/.ssh/id_rsa.pub chsu6@152.7.99.160

# 
#scp gmond.conf chsu6@152.7.99.160:~/
#ssh chsu6@152.7.99.160 'cat gmond.conf'
