#!/bin/bash

#download cloudwatch agent 
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

#install the package 
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb 

#download config json and config script
#JC suggests using the file provisioner to move transfer these files 
cd /opt/aws/amazon-cloudwatch-agent/bin/
sudo wget https://prod-cicdshared-utility-1hzwhron259mj.s3-eu-west-1.amazonaws.com/CloudWatchAgentConfig/linux-agent-config.json
sudo wget https://prod-cicdshared-utility-1hzwhron259mj.s3-eu-west-1.amazonaws.com/CloudWatchAgentConfig/configureCloudWatch.sh

#copied from previous setup script install-docker.sh 
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
