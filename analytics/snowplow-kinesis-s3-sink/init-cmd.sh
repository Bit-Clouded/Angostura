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
BYTE_THRESHOLD=50000000 #50MB
RECORD_THRESHOLD=5000000 #5mil
TIME_THRESHOLD=300000 #5min
BUCKET_TIMEOUT=1200000 #20min
# Yes I'm obsessed with 5.

LOG_LEVEL=WARN

# Externally Fed Variables
sed -i "s/{{sinkKinesisInStreamName}}/$STREAM_SOURCE/g" ./config.hocon
sed -i "s/{{sinkKinesisAppName}}/$DDB_CHECKPOINT/g" ./config.hocon
sed -i "s/{{sinkKinesisOutStreamName}}/$STREAM_BAD/g" ./config.hocon
sed -i "s/{{sinkKinesisS3Bucket}}/$BUCKET_NAME/g" ./config.hocon
sed -i "s/{{sinkKinesisS3MaxTimeout}}/$BUCKET_TIMEOUT/g" ./config.hocon

# Internal Variables
sed -i "s/{{sinkKinesisRegion}}/$EC2_REGION/g" ./config.hocon
sed -i "s/{{sinkKinesisS3Region}}/$EC2_REGION/g" ./config.hocon

sed -i "s/{{sinkLzoBufferByteThreshold}}/$BYTE_THRESHOLD/g" ./config.hocon
sed -i "s/{{sinkLzoBufferRecordThreshold}}/$RECORD_THRESHOLD/g" ./config.hocon
sed -i "s/{{sinkLzoBufferTimeThreshold}}/$TIME_THRESHOLD/g" ./config.hocon

# Change log level
sed -i "s/{{sinkLzoLogLevel}}/$LOG_LEVEL/g" ./config.hocon

echo Starting...
java -jar ./$SKS_JAR --config ./config.hocon