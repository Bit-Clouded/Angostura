FROM docker.elastic.co/logstash/logstash-oss:6.5.1

USER root

RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-aws-sqs3-default.conf ./
ADD entrypoint.sh ./
ADD logstash.yml /usr/share/logstash/config/
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
