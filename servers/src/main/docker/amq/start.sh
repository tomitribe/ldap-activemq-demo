#!/bin/bash
set -e

IFS=', ' read -r -a array <<< "$WAIT_FOR"
for element in "${array[@]}"
do
    /usr/local/bin/dockerize -wait tcp://$element -wait-retry-interval 2s -timeout 600s
done

if [ ! -z "$AMQ_XML" ]
  then
    echo "Writing custom activemq.xml file from AMQ_XML environment variable..."
    rm /opt/activemq/conf/activemq.xml
    touch /opt/activemq/conf/activemq.xml
    echo "$AMQ_XML" > /opt/activemq/conf/activemq.xml
fi

if [ ! -z "$LOG4J_PROPS" ]
  then
    echo "Writing custom log4j.properties file from LOG4J_PROPS environment variable..."
    rm /opt/activemq/conf/log4j.properties
    touch /opt/activemq/conf/log4j.properties
    echo "$LOG4J_PROPS" > /opt/activemq/conf/log4j.properties
fi

echo "All dependencies are online. Starting up this service now."
/opt/activemq/bin/activemq $1
