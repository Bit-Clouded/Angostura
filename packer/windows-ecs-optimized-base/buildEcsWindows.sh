#!/bin/bash

aws s3 cp config/agent-config.json s3://prod-cicdshared-utility-1hzwhron259mj/CloudWatchAgentConfig/agent-config.json --acl public-read
aws s3 cp config/configureCloudWatch.ps1 s3://prod-cicdshared-utility-1hzwhron259mj/CloudWatchAgentConfig/configureCloudWatch.ps1 --acl public-read


../packer build ecsWindowsAmi.json