FROM public.ecr.aws/lambda/provided:latest

RUN yum install -y awscli

COPY bootstrap /var/runtime/bootstrap
COPY test.sh /var/runtime/test.sh

RUN chmod 755 /var/runtime/bootstrap /var/runtime/test.sh

CMD ["test.handler"]