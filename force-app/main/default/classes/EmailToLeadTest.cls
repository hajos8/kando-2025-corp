@isTest
private class EmailToLeadTest {

    @isTest
    static void testBehavior() {
        // Test implementation goes here
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.fromAddress = 'markus@kkando.hu';
        email.fromName = 'Markus Erika';
        email.subject = 'Interested in your physics';
        email.plainTextBody = 'Please send me more physics information.';
        email.binaryAttachments = new List<Messaging.InboundEmail.BinaryAttachment>();

        Messaging.InboundEmail.BinaryAttachment bAttachment = new Messaging.InboundEmail.BinaryAttachment();
        bAttachment.fileName = 'test.txt';
        bAttachment.body = Blob.valueOf('This is a test attachment.');
        email.binaryAttachments.add(bAttachment);

        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        EmailToLeadHandler handler = new EmailToLeadHandler();
        Messaging.InboundEmailResult result = handler.handleInboundEmail(email, envelope);

        System.assert(result != null, 'Result should not be null');
        System.assert(result.success == true, 'Email processing should be successful');

        result = handler.handleInboundEmail(new Messaging.InboundEmail(), envelope);
    }
}