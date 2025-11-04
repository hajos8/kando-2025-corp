public with sharing class EmailToLeadHandler implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        //process email
        String fromAddress = email.fromAddress;
        String subject = email.subject;
        String body = email.plainTextBody; //TODO handle HTML body if needed

        System.debug('fromAddress' + fromAddress);
        System.debug('subject' + subject);
        System.debug('body' + body);

        result.success = true;
        return result;
    }
}

