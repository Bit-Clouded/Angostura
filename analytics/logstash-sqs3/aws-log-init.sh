#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

echo Sqs Name: $SQS
echo Elasticsearch Host: $ES_HOST
echo Raw Log Bucket: $RAW_BUCKET
echo S3 Access Log Bucket: $S3_BUCKET
echo CF Access Log Bucket: $CF_BUCKET
echo =====================================
echo Region: $EC2_REGION

sed -i "s/{{aws-region}}/$EC2_REGION/g" ./ls-aws-sqs3.conf
sed -i "s/{{sqs-name}}/$SQS/g" ./ls-aws-sqs3.conf
sed -i "s/{{es-host}}/$ES_HOST/g" ./ls-aws-sqs3.conf
sed -i "s/{{raw-log-bucket}}/$RAW_BUCKET/g" ./ls-aws-sqs3.conf
sed -i "s/{{s3-access-log-bucket}}/$S3_BUCKET/g" ./ls-aws-sqs3.conf
sed -i "s/{{cf-access-log-bucket}}/$CF_BUCKET/g" ./ls-aws-sqs3.conf

#./bin/logstash -f ./ls-aws-sqs3.conf
