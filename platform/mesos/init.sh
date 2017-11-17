#!/bin/bash

ZK_LIST=$(curl $EXHIBITOR_URL | \
    jq '.servers | join(":2181,") + ":2181"' --raw-output)
PVT_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

if [ "$1" == "master" ]; then
    ./bin/mesos-master.sh \
        --zk=zk://$ZK_LIST/mesos \
        --work_dir=/mesos/workdir/ \
        --quorum=2 \
        --hostname=$PVT_ADDRESS
else
    ./bin/mesos-slave.sh \
        --master=zk://$ZK_LIST/mesos \
        --work_dir=/mesos/workdir/ \
        --no-systemd_enable_support \
        --hostname=$PVT_ADDRESS \
        --containerizers=mesos,docker
fi
