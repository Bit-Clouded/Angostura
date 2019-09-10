#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

echo Sqs Name: $SQS
echo Elasticsearch Host: $ES_HOST
echo Critical Events: $CRITICAL_EVENTS
echo Warning Events: $WARNING_EVENTS
echo =====================================
echo Region: $EC2_REGION

sed -i "s/{{aws-region}}/$EC2_REGION/g" ./ls-aws-sqs3-default.conf
sed -i "s/{{sqs-name}}/$SQS/g" ./ls-aws-sqs3-default.conf
sed -i "s/{{es-host}}/$ES_HOST/g" ./ls-aws-sqs3-default.conf
sed -i "s/{{critical-events}}/$CRITICAL_EVENTS/g" ./ls-aws-sqs3-default.conf
sed -i "s/{{warning-events}}/$WARNING_EVENTS/g" ./ls-aws-sqs3-default.conf

logstash -f ./ls-aws-sqs3-default.conf
