FROM docker.elastic.co/elasticsearch/elasticsearch:6.1.1

RUN yes | elasticsearch-plugin install --batch discovery-ec2
RUN yes | elasticsearch-plugin install --batch repository-s3
ADD ./elasticsearch.yml ./config
