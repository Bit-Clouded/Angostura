FROM logstash:2.4.1-1

RUN logstash-plugin install --version 2.0.6 logstash-input-s3 && \
    logstash-plugin install logstash-output-elasticsearch && \
	logstash-plugin install logstash-filter-fingerprint

RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-aws-sqs3.conf ./
ADD entrypoint.sh ./
RUN chmod +x ./entrypoint.sh
ADD s3.rb /opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-input-s3-2.0.6/lib/logstash/inputs/

ENTRYPOINT ["./entrypoint.sh"]