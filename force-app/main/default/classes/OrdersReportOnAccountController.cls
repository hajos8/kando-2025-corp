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

        OrdersReportOnAccountController.queryAccount(accountId);

        populateExcelData(accountId);

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
     */
    public static void queryAccount(String accountId) {
        Account acc;

    }

    /**
     * Fill excelData
     *
     * @param accountId Account.Id
     */
    public void populateExcelData(String accountId) {
        OrdersReportOnAccountController.queryAccount(accountId);

    }

    /**
     * Pass excelData to LWC
     *
     * @param accountId Account.Id
     */
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