#!/bin/bash

java -jar exhibitor-1.0-jar-with-dependencies.jar -c s3 \
    --s3config {{bucket-name}}:exhibitor-zk.config \
    --s3region {{region}} \
    --defaultconfig /exhibitor/exhibitor-defaults.properties