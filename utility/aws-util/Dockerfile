FROM alpine:3.6

RUN apk add --no-cache ca-certificates python py-pip groff less
RUN pip install awscli
RUN pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
