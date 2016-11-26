#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

COLLECTOR_PORT=80
#cookies
COOKIE_EXPIRATION="36500 days" #100 years
COOKIE_NAME="bitclouded-snowplow"
#backoffs
MIN_BACKOFF=1000
MAX_BACKOFF=100000
# Need to observe kinesis shard limit
BYTE_THRESHOLD=2500
RECORD_THRESHOLD=250
TIME_THRESHOLD=250

# Externally Fed Variables
sed -i "s/{{collectorKinesisStreamGoodName}}/$STREAM_GOOD/g" ./conifg.hocon
sed -i "s/{{collectorKinesisStreamBadName}}/$STREAM_BAD/g" ./conifg.hocon

# Internal Variables
sed -i "s/{{collectorPort}}/$COLLECTOR_PORT/g" ./conifg.hocon
sed -i "s/{{collectorCookieExpiration}}/$COOKIE_EXPIRATION/g" ./conifg.hocon
sed -i "s/{{collectorCookieName}}/$COOKIE_NAME/g" ./conifg.hocon
sed -i "s/{{collectorSinkKinesisStreamRegion}}/$EC2_REGION/g" ./conifg.hocon
sed -i "s/{{collectorSinkKinesisMinBackoffMillis}}/$MIN_BACKOFF/g" ./conifg.hocon
sed -i "s/{{collectorSinkKinesisMaxBackoffMillis}}/$MAX_BACKOFF/g" ./conifg.hocon
sed -i "s/{{collectorSinkBufferByteThreshold}}/$BYTE_THRESHOLD/g" ./conifg.hocon
sed -i "s/{{collectorSinkBufferRecordThreshold}}/$RECORD_THRESHOLD/g" ./conifg.hocon
sed -i "s/{{collectorSinkBufferTimeThreshold}}/$TIME_THRESHOLD/g" ./conifg.hocon

echo Starting...
java -jar ./$SSSC_JAR --config ./config.hocon