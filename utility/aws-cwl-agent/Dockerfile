FROM ubuntu:14.04.4

ADD awslogs-agent-setup.py CloudWatchMonitoringScripts-1.2.1.zip default.conf /home/local/
RUN apt-get update && \
    apt-get install -y python curl unzip libwww-perl libdatetime-perl

RUN unzip /home/local/CloudWatchMonitoringScripts-1.2.1.zip && \
    rm /home/local/CloudWatchMonitoringScripts-1.2.1.zip
RUN python /home/local/awslogs-agent-setup.py \
        -r {{aws-region}} \
        -c /home/local/default.conf \
        -n && \
    service awslogs stop
RUN rm -f /home/local/awslogs-agent-setup.py && \
    rm -f /var/log/awslogs.log && \
    rm -f /var/awslogs/state/agent-state

VOLUME ["/var/awslogs/state/"]

ADD entrypoint.sh /home/local/
RUN chmod +x /home/local/entrypoint.sh

ENTRYPOINT ["/home/local/entrypoint.sh"]
