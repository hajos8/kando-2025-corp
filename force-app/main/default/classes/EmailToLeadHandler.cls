public with sharing class EmailToLeadHandler implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        //process email
        String fromAddress = email.fromAddress;
        Lead[] existingLeads = [SELECT Id FROM Lead WHERE Email = :email.fromAddress LIMIT 1];
        if(existingLeads.isEmpty()){
            result.success = true;
            return result;
        }

        String subject = email.subject;
        String body = email.plainTextBody; //TODO handle HTML body if needed

        System.debug('fromAddress' + fromAddress);
        System.debug('subject' + subject);
        System.debug('body' + body);

        Lead lead = new Lead();
        lead.LastName = email.fromName;
        lead.Company = 'Unknown';
        lead.Email = fromAddress;

        lead.Title = subject;
        lead.Description = body;

        Database.SaveResult sr = null;

        try{
            sr = Database.insert(lead, false);
            if (!sr.isSuccess()) {
                for (Database.Error err : sr.getErrors()) {
                    System.debug('Error inserting lead: ' + err.getMessage());
                }
                result.success = false;
                return result;
            }
            else{
                result.success = true;
                return result;
            }
        }
        catch(Exception e){
            System.debug('Exception inserting lead: ' + e.getMessage());
            result.success = false;
            return result;
        }
    }
}

