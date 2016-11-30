FROM openjdk:8u111-jdk

RUN apt-get update -qq && apt-get install -qqy lzop liblzo2-dev
RUN mkdir /snowplow
WORKDIR /snowplow

ENV SKS_VERSION 0.4.0
ENV SKS_JAR snowplow-kinesis-s3-$SKS_VERSION
ENV SKS_ZIP kinesis_s3_$SKS_VERSION.zip

ADD http://dl.bintray.com/snowplow/snowplow-generic/$SKS_ZIP ./
RUN unzip $SKS_ZIP
