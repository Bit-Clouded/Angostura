FROM debian:7.8

ENV ZK_RELEASE="http://www.apache.org/dist/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz" \
    EXHIBITOR_POM="https://raw.githubusercontent.com/Netflix/exhibitor/d911a16d704bbe790d84bbacc655ef050c1f5806/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml"

RUN apt-get update -qqy \
    && apt-get install -qqy curl maven openjdk-7-jdk

RUN curl -Lo /tmp/zookeeper.tgz $ZK_RELEASE \
    && mkdir -p /opt/zookeeper/transactions /opt/zookeeper/snapshots \
    && tar -xzf /tmp/zookeeper.tgz -C /opt/zookeeper --strip=1 \
    && rm /tmp/zookeeper.tgz

RUN mkdir -p /opt/exhibitor \
    && curl -Lo /opt/exhibitor/pom.xml $EXHIBITOR_POM \
    && mvn -f /opt/exhibitor/pom.xml package \
    && ln -s /opt/exhibitor/target/exhibitor*jar /opt/exhibitor/exhibitor.jar

WORKDIR /opt/exhibitor
ADD ./ ./
EXPOSE 2181 2888 3888 8181

ENTRYPOINT ["bash", "-ex", "/opt/exhibitor/init.sh"]
