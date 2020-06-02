FROM python:3-alpine
LABEL maintainer "Mathias Söderberg <mths@sdrbrg.se>"

RUN apk --no-cache add bash bind-tools && \
  pip install --no-cache-dir awscli==1.11.158

COPY ddns-route53 /usr/local/bin/ddns-route53

ENV AWS_ACCESS_KEY_ID ACCESSKEYID
ENV AWS_SECRET_ACCESS_KEY SECRETACCESSKEY

ENTRYPOINT ["/usr/local/bin/ddns-route53"]
