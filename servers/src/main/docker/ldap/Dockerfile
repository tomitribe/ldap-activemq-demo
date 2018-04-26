FROM ${images.owner}/ldap-amq-demo-base:${project.version}

RUN apt-get update
RUN apt-get install ldap-utils -y

RUN mkdir -p /opt
WORKDIR /opt

RUN curl -L -s -o apacheds.tar.gz http://mirror.nbtelecom.com.br/apache//directory/apacheds/dist/2.0.0-M24/apacheds-2.0.0-M24.tar.gz
RUN tar xvzf apacheds.tar.gz && rm apacheds.tar.gz && mv apache* apacheds

COPY init.ldif .
COPY init.sh .
COPY start.sh .
RUN chmod u+x start.sh
RUN chmod u+x init.sh

ENTRYPOINT ["/opt/start.sh"]
CMD ["run"]

