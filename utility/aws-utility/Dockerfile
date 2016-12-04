FROM alpine:3.4

ENV AWS_BOOTSTRAP=https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
RUN apk -Uuv add py-pip ca-certificates curl && \
	pip install awscli && \
    /usr/bin/easy_install-2.7 $AWS_BOOTSTRAP && \ 
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*
	
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.2
#ENV DOCKER_SHA256 626601deb41d9706ac98da23f673af6c0d4631c4d194a677a9a1a07d7219fa0f

RUN set -x \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    #&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v

CMD ["sh"]