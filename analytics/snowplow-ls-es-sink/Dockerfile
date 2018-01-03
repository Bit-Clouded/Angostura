FROM docker.elastic.co/logstash/logstash-oss:6.1.1

RUN logstash-plugin install logstash-input-kinesis && \
    logstash-plugin install logstash-output-elasticsearch

USER root
RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-snowplow-es.conf ./
ADD entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]