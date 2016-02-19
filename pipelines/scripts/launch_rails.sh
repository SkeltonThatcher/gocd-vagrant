#!/bin/bash
. ~/.bash_profile
cd /var/lib/go-agent/pipelines/demo
nohup sh /vagrant/pipelines/scripts/launch_rails_aux.sh 
exit 0

