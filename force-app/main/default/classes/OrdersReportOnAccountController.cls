/**
 * Controller class for Orders Report on Account Preview LWC
 *
 * @author TODO
 * @since 2025-12-16
 */
public with sharing class OrdersReportOnAccountController {
    public String accountId {get; set;}
    public Account acc {get; set;}
    public List<List<String>> excelData {get; set;}

    /**
     * Constructor populates accountId, acc, excelData by page's "id"=Account.Id URL query search parameter
     */
    public OrdersReportOnAccountController() {
        if(ApexPages.currentPage() != null && ApexPages.currentPage().getParameters().containsKey('id')){
            accountId = ApexPages.currentPage().getParameters().get('id');
        }

        if(String.isNotBlank(accountId)){
            acc = OrdersReportOnAccountController.queryAccount(accountId);
        }

        if(acc != null){
            populateExcelData(accountId);
        }

    }

    /**
     * Constructor populates accountId, acc, excelData by controller's id
     *
     * @param controller Account controller
     */
    public OrdersReportOnAccountController(ApexPages.StandardController controller) {

        populateExcelData(accountId);

    }

    /**
     * Get orders and order items of account
     *
     * @param accountId Account.Id
     * @return Account with Orders and OrderItems
     * https://orgfarm-f98de8abd2-dev-ed--c.develop.vf.force.com/apex/OrderExcelReport?id=801gK00000P2LZqQAN
     */
    public static Account queryAccount(String accountId) {
        Account acc;

        if(String.isNotBlank(accountId)){
            acc = [SELECT 
            Id, 
            Name, 
            (SELECT 
            Id, 
            OrderNumber, 
            Status, 
            TotalAmount,
            ActivatedDate,
            EffectiveDate,
            (SELECT 
                Id,
                Product2Id,
                Product2.Name,
                Quantity,
                UnitPrice,
                ListPrice,
                TotalPrice
                FROM OrderItems)
            FROM Orders
            WHERE ActivatedDate >= LAST_WEEK) 
            FROM Account WHERE Id = :accountId LIMIT 1];
        }

        return acc;
    }

    /**
     * Fill excelData
     *
     * @param accountId Account.Id
     */
    public void populateExcelData(String accountId) {
        Account acc = OrdersReportOnAccountController.queryAccount(accountId);
        excelData = new List<List<String>>();

        if(acc != null && acc.Orders != null && !acc.Orders.isEmpty()){
            // Header row
            List<String> headerRow = new List<String>{'Order Number', 'Order Status', 'Activated Date', 'Total Amount', 'Product Name', 'Quantity', 'Unit Price', 'List Price', 'Total Price'};
            excelData.add(headerRow);

            // Data rows
            for(Order ord : acc.Orders){
                if(ord.OrderItems != null && !ord.OrderItems.isEmpty()){
                    for(Order order : acc.Orders){
                        if(order.OrderItems != null && !order.OrderItems.isEmpty()){
                            for(OrderItem oi : order.OrderItems){
                                if(oi.Quantity > 0){
                                    excelData.add(new List<String>{
                                        order.OrderNumber,
                                        order.Status,
                                        String.valueOf(order.EffectiveDate),
                                        String.valueOf(order.ActivatedDate),
                                        oi.Product2.Name,
                                        oi.Product2.description,
                                        String.valueOf(oi.Quantity),
                                        String.valueOf(oi.UnitPrice)
                                    });
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    /**
     * Pass excelData to LWC
     *
     * @param accountId Account.Id
     */
    @AuraEnabled
    public static string methodName(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    public static void getTableData(String accountId) {
        queryAccount(accountId);

        OrdersReportOnAccountController instance = new OrdersReportOnAccountController();
        instance.accountId = accountId;
        instance.populateExcelData(accountId);


    }

    /**
     * Create file and return its ContentDocumentId
     *
     * @param accountId Account.Id
     */
    public static void createContentVersion(String accountId) {

        ContentVersion cv = new ContentVersion();

        ContentDocumentLink cdl = new ContentDocumentLink();



    }
}
