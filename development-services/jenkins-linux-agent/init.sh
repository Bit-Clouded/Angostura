#!/bin/bash

AGENT_NAME=lin-$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
DESCRIPTION=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
EXECUTOR_COUNT=$(grep -c ^processor /proc/cpuinfo)

echo Jenkins Host: $JENKINS_HOST
echo Agent Name: $AGENT_NAME
echo Description: $DESCRIPTION
echo Executor Count: $EXECUTOR_COUNT

java -jar /home/local/swarm-client-2.0-jar-with-dependencies.jar \
	-master http://$JENKINS_HOST:8080 \
	-username $JENKINS_USERNAME -password $JENKINS_PASSWORD \
	-name $AGENT_NAME -description $DESCRIPTION \
	-executors $EXECUTOR_COUNT -labels linux
