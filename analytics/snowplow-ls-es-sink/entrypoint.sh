#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

sed -i "s/{{aws-region}}/$EC2_REGION/g" ./ls-snowplow-es.conf
sed -i "s/{{stream-name}}/$STREAM_SOURCE/g" ./ls-snowplow-es.conf
sed -i "s/{{checkpoint-ddb}}/$DDB_CHECKPOINT/g" ./ls-snowplow-es.conf
sed -i "s/{{es-host}}/$ES_HOST/g" ./ls-snowplow-es.conf

sed -i "s/{{index-name}}/${STREAM_SOURCE,,}/g" ./ls-snowplow-es.conf

logstash -f ./ls-snowplow-es.conf
