#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
AWS_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_HOSTNAME=`curl -s http://169.254.169.254/latest/meta-data/local-hostname`

cat <<- EOF > /opt/exhibitor/defaults.conf
	zookeeper-data-directory=/opt/zookeeper/snapshots
	zookeeper-install-directory=/opt/zookeeper
	zookeeper-log-directory=/opt/zookeeper/transactions
	log-index-directory=/opt/zookeeper/transactions
	cleanup-period-ms=300000
	check-ms=30000
	backup-period-ms=600000
	client-port=2181
	cleanup-max-files=20
	backup-max-store-ms=21600000
	connect-port=2888
	observer-threshold=0
	election-port=3888
	zoo-cfg-extra=tickTime\=2000&initLimit\=10&syncLimit\=5&quorumListenOnAllIPs\=true
	auto-manage-instances-settling-period-ms=0
	auto-manage-instances=1
	auto-manage-instances-fixed-ensemble-size=0
        backup-extra=throttle\=&bucket-name\=${S3_BUCKET}&key-prefix\=data/&max-retries\=4&retry-sleep-ms\=30000
EOF

if [[ -n ${ZK_PASSWORD} ]]; then
	SECURITY="--security web.xml --realm Zookeeper:realm --remoteauth basic:zk"
	echo "zk: ${ZK_PASSWORD},zk" > realm
fi

exec 2>&1

java -jar /opt/exhibitor/exhibitor.jar \
  --port 8181 --defaultconfig /opt/exhibitor/defaults.conf \
  --configtype s3 --s3config ${S3_BUCKET}:exhibitor-config --s3region ${AWS_REGION} --s3backup true \
  --hostname $PVT_HOSTNAME \
  ${SECURITY}
