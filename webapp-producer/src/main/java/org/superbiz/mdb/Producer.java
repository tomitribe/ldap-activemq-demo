package org.superbiz.mdb;

import javax.annotation.Resource;
import javax.ejb.Schedule;
import javax.ejb.Stateless;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;

@Stateless
public class Producer {

    @Resource(name = "MyJmsConnectionFactory")
    private ConnectionFactory connectionFactory;

    @Resource(name = "logsQueue")
    private Queue vector;

    @Schedule(hour = "*", minute = "*", second = "*/10", persistent = false)
    public void sendMessage() throws JMSException {
        try (final Connection connection = connectionFactory.createConnection()) {
            connection.start();
            try (final Session session = connection.createSession(true, Session.AUTO_ACKNOWLEDGE)) {
                try (final MessageProducer producer = session.createProducer(vector)) {
                    final Message msg = session.createMessage();
                    msg.setStringProperty("text", "Hi from producer [" + System.currentTimeMillis() + "]");
                    producer.send(msg);
                }
            }
        }
    }

}
