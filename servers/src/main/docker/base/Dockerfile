FROM openjdk:8u162-jdk-stretch

RUN apt-get update
RUN apt-get install gnupg curl openssl bash wget strace lsof procps -y
RUN mkdir -p /opt
WORKDIR /opt

ENV DOCKERIZE_VERSION v0.6.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY 10-ptrace.conf /etc/sysctl.d/10-ptrace.conf

RUN addgroup --system jdoe
RUN adduser --system --ingroup jdoe jdoe

WORKDIR /opt
RUN chown -R jdoe:jdoe /opt

USER jdoe

