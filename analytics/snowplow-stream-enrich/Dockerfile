FROM openjdk:8u111-jdk

RUN mkdir -p /snowplow
WORKDIR /snowplow
ADD ./config.hocon ./
ADD ./resolver.config ./
ADD ./init-cmd.sh ./
RUN chmod +x ./init-cmd.sh

ENV SSE_VERSION 0.10.0
ENV SSE_JAR snowplow-stream-enrich-$SSE_VERSION
ENV SSE_ZIP snowplow_stream_enrich_$SSE_VERSION.zip
ADD http://dl.bintray.com/snowplow/snowplow-generic/$SSE_ZIP ./
RUN unzip ./$SSE_ZIP

CMD ["./init-cmd.sh"]