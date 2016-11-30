FROM logstash:2.4.1-1

RUN logstash-plugin install logstash-input-kinesis && \
    logstash-plugin install logstash-output-elasticsearch

RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-snowplow-es.conf ./
ADD entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]