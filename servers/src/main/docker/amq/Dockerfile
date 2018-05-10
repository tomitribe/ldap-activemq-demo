FROM ${images.owner}/ldap-amq-demo-base:${project.version}

USER jdoe

RUN curl -s -o activemq.tar.gz http://apache.mirror.rafal.ca/activemq/${amq.version}/apache-activemq-${amq.version}-bin.tar.gz
RUN curl -s -o activemq.asc https://www.apache.org/dist/activemq/${amq.version}/apache-activemq-${amq.version}-bin.tar.gz.asc
RUN curl -s -o KEYS https://www.apache.org/dist/activemq/KEYS
RUN gpg --import KEYS && gpg --verify activemq.asc activemq.tar.gz && rm activemq.asc KEYS
RUN tar xzf activemq.tar.gz && rm activemq.tar.gz
RUN mv apache-* activemq

WORKDIR /opt/activemq/conf
COPY activemq.xml .
COPY login.config .
COPY credentials.properties .

WORKDIR /opt/activemq

COPY start.sh .
USER root
RUN chmod u+x start.sh
USER jdoe

WORKDIR /opt

RUN keytool -noprompt -storepass changeit -keypass changeit -genkey \
    -alias broker \
    -keyalg RSA \
    -keysize 2048 \
    -validity 90 \
    -dname "CN=mdb.superbiz.org, OU=MDB, O=SUPERBIZ, L=Montreal, S=QC, C=CA" \
    -keystore broker.ks

RUN keytool -export \
    -alias broker \
    -keystore broker.ks \
    -file broker_cert \
    -storepass changeit

ENV ACTIVEMQ_SSL_OPTS="-Djavax.net.ssl.keyStore=/opt/broker.ks -Djavax.net.ssl.keyStorePassword=changeit"

RUN keytool -noprompt -storepass changeit -keypass changeit -genkey \
    -alias client \
    -keyalg RSA \
    -keysize 2048 \
    -validity 90 \
    -dname "CN=mdb.superbiz.org, OU=MDB, O=SUPERBIZ, L=Montreal, S=QC, C=CA" \
    -keystore client.ks

RUN keytool -import -alias broker -keystore client.ts -file broker_cert -storepass changeit -noprompt

WORKDIR /opt/activemq
ENTRYPOINT ["/opt/activemq/start.sh"]
CMD ["console"]



