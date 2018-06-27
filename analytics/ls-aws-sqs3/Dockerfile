FROM docker.elastic.co/logstash/logstash:6.1.1

USER root
RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-aws-sqs3.conf ./
ADD entrypoint.sh ./
ADD logstash.yml /usr/share/logstash/config/
RUN chmod +x ./entrypoint.sh
ADD s3.rb /usr/share/logstash/vendor/bundle/jruby/2.3.0/gems/logstash-input-s3-3.1.8/lib/logstash/inputs/

ENTRYPOINT ["./entrypoint.sh"]
