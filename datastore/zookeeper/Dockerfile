FROM openjdk:8u111-jdk

ENV ZK_VERSION=3.4.6

RUN apt-get update -qq && apt-get install -qqy ca-certificates maven &&\
    wget -q http://archive.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz.md5 &&\
    wget -q http://archive.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz &&\
    md5sum -c zookeeper-$ZK_VERSION.tar.gz.md5 &&\
    tar xzf zookeeper-$ZK_VERSION.tar.gz &&\
    rm /zookeeper-$ZK_VERSION.tar.gz* &&\
    mv /zookeeper-$ZK_VERSION /zookeeper
  
WORKDIR /exhibitor

ADD exhibitor-default.properties ./
ADD pom.xml ./
RUN mvn assembly:single &&\
    mv target/exhibitor-1.0-jar-with-dependencies.jar . &&\
    rm -rf /exhibitor/target &&\
    rm /exhibitor/pom.xml

EXPOSE 2181 2888 3888 8080

CMD ["cmd.sh"]