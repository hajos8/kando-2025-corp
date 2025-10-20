public with sharing class QuoteProductsController{
    public Quote quote {get; set;}
    public Id qliId {get; set;}

    public QuoteProductsController(ApexPages.StandardController stdController){
        quote = (Quote) stdController.getRecord();
        
        if(ApexPages.currentPage().getParameters().containsKey('qliId')){
            qliId = ApexPages.currentPage().getParameters().get('qliId');
            System.debug('qliId: ' + qliId);

            QuoteLineItem[] qlis = [SELECT Id FROM QuoteLineItem WHERE Id = :qliId];

            if(qlis.isEmpty()){
                QuoteLineItem qli = qlis[0];
                quote.Id = qli.QuoteId;

                Quote[] q = [SELECT 
                Id, Name, Status, Opportunity.Name, (SELECT Id, Product2Id, Product2.Name, Quantity, UnitPrice FROM QuoteLineItems)
                FROM Quote WHERE Id = :quote.Id];

                if(q != null){
                    quote = q[0];
                }
            }
        }
    }
}