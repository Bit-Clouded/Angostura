#!/bin/bash

#download cloudwatch agent 
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

#install the package 
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb 



echo Copy config from tmp folder...
sudo cp /tmp/linux-agent-config.json /opt/aws/amazon-cloudwatch-agent/bin/linux-agent-config.json



#install docker
sudo apt-get update

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get -y install docker-ce containerd.io



# Update SSM agent with snap 
sudo snap refresh amazon-ssm-agent --classic
sudo snap services amazon-ssm-agent

