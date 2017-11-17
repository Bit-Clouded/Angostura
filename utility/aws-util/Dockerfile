FROM alpine:3.6

RUN apk add --no-cache ca-certificates python py-pip groff less jq curl &&\
    pip install awscli &&\
    pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz

ADD ./get-asg-peers /usr/bin
RUN chmod +x /usr/bin/get-asg-peers