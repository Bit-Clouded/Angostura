FROM docker.elastic.co/logstash/logstash:6.5.1

USER root

RUN bin/logstash-plugin install --no-verify

RUN mkdir -p /bc/temp/
WORKDIR /bc/
#ADD ls-aws-sqs3.conf ./
#ADD entrypoint.sh ./
#ADD logstash.yml /usr/share/logstash/config/
#RUN chmod +x ./entrypoint.sh


#ENTRYPOINT ["./entrypoint.sh"]
