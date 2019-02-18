#!/bin/bash

aws s3 cp config/agent-config.json s3://prod-cicdshared-utility-1hzwhron259mj/CloudWatchAgentConfig/agent-config.json
aws s3 cp config/configureCloudWatch.ps1 s3://prod-cicdshared-utility-1hzwhron259mj/CloudWatchAgentConfig/configureCloudWatch.ps1


../packer build windowsDevNoRegions.json