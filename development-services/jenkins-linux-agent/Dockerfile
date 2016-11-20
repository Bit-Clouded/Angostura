FROM openjdk:8u111-jdk

RUN apt-get install -qqy \
    ca-certificates \
    curl \
    openssl

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.2

RUN set -x \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    #&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v

RUN mkdir /home/local/
ADD http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar /home/local/
ADD init.sh /home/local/
RUN chmod +x /home/local/init.sh

ENTRYPOINT ["/home/local/init.sh"]
