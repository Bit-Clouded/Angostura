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

LOG_LEVEL=INFO

# Externally Fed Variables
sed -i "s/{{enrichStreamsInRaw}}/$STREAM_SOURCE/g" ./config.hocon
sed -i "s/{{enrichStreamsAppName}}/$DDB_CHECKPOINT/g" ./config.hocon
sed -i "s/{{enrichStreamsOutEnriched}}/$STREAM_GOOD/g" ./config.hocon
sed -i "s/{{enrichStreamsOutBad}}/$STREAM_BAD/g" ./config.hocon

# Internal Variables
sed -i "s/{{enrichStreamsBufferByteThreshold}}/$BYTE_THRESHOLD/g" ./config.hocon
sed -i "s/{{enrichStreamsBufferRecordThreshold}}/$RECORD_THRESHOLD/g" ./config.hocon
sed -i "s/{{enrichStreamsBufferTimeThreshold}}/$TIME_THRESHOLD/g" ./config.hocon

sed -i "s/{{enrichStreamsOutMinBackoff}}/$MIN_BACKOFF/g" ./config.hocon
sed -i "s/{{enrichStreamsOutMaxBackoff}}/$MAX_BACKOFF/g" ./config.hocon

sed -i "s/{{enrichStreamsRegion}}/$EC2_REGION/g" ./config.hocon

sed -i "s/{{collectorPort}}/$COLLECTOR_PORT/g" ./config.hocon
sed -i "s/{{collectorCookieExpiration}}/$COOKIE_EXPIRATION/g" ./config.hocon
sed -i "s/{{collectorCookieName}}/$COOKIE_NAME/g" ./config.hocon

# Change log level
sed -i "s/loglevel = DEBUG/loglevel = $LOG_LEVEL/g" ./config.hocon
echo Starting...
java -jar ./$SSE_JAR --config ./config.hocon --resolver file:./resolver.config