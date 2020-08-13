FROM python:3-alpine
LABEL maintainer "Mathias Söderberg <mths@sdrbrg.se>"

ENV AWSCLI_VERSION 1.18.119

RUN apk --no-cache add bash bind-tools && \
  pip install --no-cache-dir awscli==${AWSCLI_VERSION}

COPY ddns-route53 /usr/local/bin/ddns-route53

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ENV AWS_ACCESS_KEY_ID     $AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY

ENTRYPOINT ["/usr/local/bin/ddns-route53"]
