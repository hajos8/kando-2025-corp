public with sharing class LeadConversionService {
    @AuraEnabled
    public static String customConvertLead(String leadId) {
        LeadStatus convertStatus = [SELECT Id, ApiName FROM LeadStatus WHERE IsConverted=TRUE LIMIT 1];

        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setConvertedStatus(convertStatus.ApiName);
        lc.setLeadId(leadId);

        Map<String, Object> results = new Map<String, Object>();

        Database.LeadConvertResult lcr = Database.convertLead(lc);
        if (lcr.isSuccess()) {
            Id accountId = lcr.getAccountId();
            Id contactId = lcr.getContactId();
            Id opportunityId = lcr.getOpportunityId();

            results.put('accountId', accountId);
            results.put('contactId', contactId);
            results.put('opportunityId', opportunityId);
        } else {
            Database.Error[] errors = lcr.getErrors();

            results.put('errors', errors);
        }
        System.debug('results: '+results);

        return JSON.serializePretty(results);
    }
}