FROM certbot/certbot:v0.18.2

RUN pip install awscli
RUN apk add --no-cache jq

RUN mkdir /bc/
WORKDIR /bc/

ADD ./manual-auth-hook.sh ./
ADD ./manual-cleanup-hook.sh ./
ADD ./change-resource-record-sets.json ./
ADD ./run.sh ./
RUN chmod +x ./*

ENTRYPOINT ["/bin/sh"]
CMD ["/bc/run.sh"]