FROM logstash:2.4.1-1

RUN logstash-plugin install --version 2.0.2 logstash-input-kinesis && \
    logstash-plugin install logstash-output-elasticsearch

RUN mkdir -p /bc/temp/
WORKDIR /bc/
ADD ls-aws-cwl.conf ./
ADD entrypoint.sh ./
ADD worker.rb /opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-input-kinesis-2.0.2-java/lib/logstash/inputs/kinesis/
RUN chmod +x ./entrypoint.sh

# Create user and assign permission
ENTRYPOINT ["./entrypoint.sh"]