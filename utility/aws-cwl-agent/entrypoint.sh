#!/bin/sh

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

echo Region: $EC2_REGION
echo Syslog CWL Group: $SYSLOG
echo Auth.log CWL Group: $AUTHLOG

CONFIG_FILE=/var/awslogs/etc/awslogs.conf
DAEMON=/var/awslogs/bin/awslogs-agent-launcher.sh
DAEMON_NAME=awslogs

DAEMON_USER=root
PIDFILE=/var/awslogs/state/awslogs.pid
LOCKFILE=/var/awslogs/state/awslogs.lock
MUTEXFILE=/var/awslogs/state/awslogs.mutex

sed -i "s/{{aws-region}}/$EC2_REGION/g" $DAEMON
sed -i "s/{{syslog-cwl-group}}/$SYSLOG/g" $CONFIG_FILE
sed -i "s/{{authlog-cwl-group}}/$AUTHLOG/g" $CONFIG_FILE

start-stop-daemon --start --pidfile $PIDFILE --user $DAEMON_USER --chuid $DAEMON_USER --startas $DAEMON
