#!/bin/bash

aws.cmd s3 cp config/linux-agent-config.json s3://prod-cicdshared-utility-1hzwhron259mj/CloudWatchAgentConfig/linux-agent-config.json --acl public-read
aws.cmd s3 cp config/configureCloudWatch.sh s3://prod-cicdshared-utility-1hzwhron259mj/CloudWatchAgentConfig/configureCloudWatch.sh --acl public-read


../packer.exe build linuxAmi.json