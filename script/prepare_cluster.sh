#! /bin/bash

#ssh-keygen -t rsa -P ""
#cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

ssh-copy-id -i $HOME/.ssh/id_rsa.pub chsu6@152.7.99.160
scp gmond.conf chsu6@152.7.99.160:~/
ssh chsu6@152.7.99.160 'cat gmond.conf'
