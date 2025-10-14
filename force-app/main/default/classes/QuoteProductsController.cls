public with sharing class QuoteProductsController{
    public Quote quote {get; set;}
    public Id qliId {get; set;}

    public QuoteProductsController(ApexPages.StandardController stdController){
        quote = (Quote) stdController.getRecord();
        
        if(ApexPages.currentPage().getParameters().containsKey('qliId')){
            qliId = ApexPages.currentPage().getParameters().get('qliId');
            System.debug('qliId: ' + qliId);
        }
    }
}