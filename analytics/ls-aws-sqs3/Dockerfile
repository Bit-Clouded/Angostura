FROM docker.elastic.co/logstash/logstash:5.6.1

USER root
RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-aws-sqs3.conf ./
ADD entrypoint.sh ./
ADD logstash.yml /usr/share/logstash/config/
RUN chmod +x ./entrypoint.sh
ADD s3.rb /usr/share/logstash/vendor/bundle/jruby/1.9/gems/logstash-input-s3-3.1.6/lib/logstash/inputs/

ENTRYPOINT ["./entrypoint.sh"]
