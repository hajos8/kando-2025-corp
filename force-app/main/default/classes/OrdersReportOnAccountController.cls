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

        if (ApexPages.currentPage() != null && ApexPages.currentPage().getParameters().containsKey('id')) {
            accountId = ApexPages.currentPage().getParameters().get('id');
        }

        if (String.isNotBlank(accountId)) {
            acc = OrdersReportOnAccountController.queryAccount(accountId);
        }

        if (acc != null) {
            excelData = populateExcelData(accountId);
        }

    }

    /**
     * Constructor populates accountId, acc, excelData by controller's id
     *
     * @param controller Account controller
     */
    public OrdersReportOnAccountController(ApexPages.StandardController controller) {
        accountId = controller.getId();
        if (String.isNotBlank(accountId)) {
            acc = OrdersReportOnAccountController.queryAccount(accountId);
        } 
        
    }

    /**
     * Get orders and order items of account
     *
     * @param accountId Account.Id
     * @return queried account
     */
    public static Account queryAccount(String accountId) {
        Account acc;

        if (String.isNotBlank(accountId)) {
            acc = [
                SELECT Id 
                    ,Name 
                    ,(SELECT Id 
                        ,OrderNumber
                        ,Status
                        ,TotalAmount
                        ,ActivatedDate
                        ,EffectiveDate
                            ,(SELECT Id 
                                ,Product2Id
                                ,Product2.Name
                                ,Product2.Description
                                ,Quantity
                                ,UnitPrice
                                ,ListPrice
                                ,TotalPrice
                                FROM OrderItems) 
                        FROM Orders
                        WHERE ActivatedDate >= LAST_WEEK
                    )
                FROM account
                WHERE Id = :accountId
                Limit 1
            ];
        }

        return acc;

    }

    /**
     * Fill excelData
     * 
     *
     * @param accountId Account.Id
     * @return excelData
     */
    public List<List<String>> populateExcelData(String accountId) {
        Account acc = OrdersReportOnAccountController.queryAccount(accountId);
        excelData = new List<List<String>>();
        if (acc != null && acc.Orders != null && !acc.Orders.isEmpty()) {
            for (Order order : acc.Orders) {
                if (order.OrderItems != null && !order.OrderItems.isEmpty()) {
                    for (OrderItem io : order.OrderItems) {
                        if (io.Quantity > 0) {
                            excelData.add(new List<String>{
                                order.OrderNumber,
                                order.Status,
                                String.valueOf(order.EffectiveDate),
                                String.valueOf(order.ActivatedDate),
                                io.Product2.Name,
                                String.isNotBlank(io.Product2.Description ) ? io.Product2.Description : '',
                                String.valueOf(io.Quantity),
                                String.valueOf(io.UnitPrice)
                            });
                        }
                        
                    }
                }
            }
        }

        System.debug('excelData: ' + excelData);
        return excelData;
    }

    /**
     * Pass excelData to LWC
     *
     * @param accountId Account.Id
     */
    @AuraEnabled
    public static List<List<String>> getTableData(String accountId) {
        queryAccount(accountId);

        OrdersReportOnAccountController instance = new OrdersReportOnAccountController();
        instance.accountId = accountId;
        return instance.populateExcelData(accountId);


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