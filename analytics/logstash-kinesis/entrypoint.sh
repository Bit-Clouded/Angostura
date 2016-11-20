#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

echo Stream Name: $KINESIS
echo Checkpoint DynamoDb Table: $DDB_CHECKPOINT
echo Elasticsearch Host: $ES_HOST
echo VPC Log Group Name: $VPC_LOG
echo CloudTrail Log Group Name: $CLOUDTRAIL
echo Docker Log Group Name: $DOCKER_LOG
echo Syslog Group Name: $SYSLOG
echo Auth.Log Group Name: $AUTHLOG
echo =====================================
echo Region: $EC2_REGION

sed -i "s/{{aws-region}}/$EC2_REGION/g" ./ls-aws-cwl.conf
sed -i "s/{{stream-name}}/$KINESIS/g" ./ls-aws-cwl.conf
sed -i "s/{{checkpoint-ddb}}/$DDB_CHECKPOINT/g" ./ls-aws-cwl.conf
sed -i "s/{{es-host}}/$ES_HOST/g" ./ls-aws-cwl.conf
sed -i "s/{{vpc-log-group}}/$VPC_LOG/g" ./ls-aws-cwl.conf
sed -i "s/{{ct-log-group}}/$CLOUDTRAIL/g" ./ls-aws-cwl.conf
sed -i "s/{{docker-log-group}}/$DOCKER_LOG/g" ./ls-aws-cwl.conf
sed -i "s/{{syslog-log-group}}/$SYSLOG/g" ./ls-aws-cwl.conf
sed -i "s/{{authlog-log-group}}/$AUTHLOG/g" ./ls-aws-cwl.conf

logstash -f ./ls-aws-cwl.conf
