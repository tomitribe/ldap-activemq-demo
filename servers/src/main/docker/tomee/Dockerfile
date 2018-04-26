FROM ${images.owner}/ldap-amq-demo-base:${project.version}

USER jdoe

ENV JPDA_ADDRESS=8000
ENV JPDA_TRANSPORT=dt_socket
ENV JPDA_SUSPEND=y

COPY tomee.tar.gz .
RUN tar xvzf tomee.tar.gz && rm tomee.tar.gz
RUN mv apache-* tomee
RUN rm -Rf /opt/tomee/webapps/*

WORKDIR /opt/tomee/

COPY start.sh .
USER root
RUN chmod u+x start.sh
USER jdoe

COPY logging.properties /opt/tomee/conf/
COPY tomee.xml /opt/tomee/conf/
RUN mkdir -p /opt/tomee/apps

ENTRYPOINT ["/opt/tomee/start.sh"]
CMD ["run"]