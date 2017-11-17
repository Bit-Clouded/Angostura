FROM ubuntu:16.04

RUN apt-get update -qqy && \
    apt-get install -qqy \
        tar wget git openjdk-8-jdk autoconf libtool \
        build-essential python-dev python-six \
        python-virtualenv libcurl4-nss-dev libsasl2-dev \
        libsasl2-modules maven libapr1-dev libsvn-dev zlib1g-dev

RUN mkdir /mesos
WORKDIR /mesos
RUN wget http://www.apache.org/dist/mesos/1.4.0/mesos-1.4.0.tar.gz && \
    tar -zxf mesos-1.4.0.tar.gz --strip-components=1 && \
    rm mesos-1.4.0.tar.gz
RUN mkdir build
WORKDIR /mesos/build
RUN ../configure && \
    make

EXPOSE 5050

ADD ./init.sh ./
RUN apt-get install -qqy curl jq docker.io && \
    chmod +x ./init.sh
RUN mkdir /mesos/workdir/
