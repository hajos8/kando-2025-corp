@isTest
private class OrderExcelTest {
        @TestSetup static void testFactory(){
        Product2 prod = new Product2(
            Name = 'Test Product',
            IsActive = true
        );
        insert prod;

        PricebookEntry pb = new PricebookEntry(
            Product2Id = prod.Id,
            Pricebook2Id = Test.getStandardPricebookId(),
            UnitPrice = 100,
            IsActive = true
        );
        insert pb;

        Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today()
            
        );
        insert opp;

        Quote quote = new Quote(
            Name = 'Test Quote',
            Status = 'Draft',
            OpportunityId = opp.Id,
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert quote;

        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            Product2Id = prod.Id,
            PricebookEntryId = pb.Id,
            Quantity = 1,
            UnitPrice = 100
        );
        insert qli;

        Contract contract = new Contract(
           AccountId = acc.Id
        );
        insert contract;

        Order ord = new Order(
            AccountId = acc.Id,
            EffectiveDate = Date.today(),
            Status = 'Draft'
        );
        insert ord;

        OrderItem oi = new OrderItem(
            OrderId = ord.Id,
            PricebookEntryId = pb.Id,
            Quantity = 1,
            UnitPrice = 100
        );
        insert oi;
    }

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
    }
}