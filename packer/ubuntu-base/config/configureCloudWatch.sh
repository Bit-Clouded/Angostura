#!/bin/bash

cd /opt/aws/amazon-cloudwatch-agent/bin/
sudo amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:linux-agent-config.json -s