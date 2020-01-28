FROM openjdk:8u242-jdk

RUN mkdir -p /snowplow
WORKDIR /snowplow
ADD ./config.hocon ./
ADD ./init-cmd.sh ./
RUN chmod +x ./init-cmd.sh

ENV SSSC_VERSION 0.9.0
ENV SSSC_JAR snowplow-stream-collector-$SSSC_VERSION
ENV SSSC_ZIP snowplow_scala_stream_collector_$SSSC_VERSION.zip
ADD http://dl.bintray.com/snowplow/snowplow-generic/$SSSC_ZIP ./
RUN unzip ./$SSSC_ZIP

CMD ["./init-cmd.sh"]