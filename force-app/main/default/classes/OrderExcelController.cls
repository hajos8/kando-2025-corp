public with sharing class OrderExcelController {
    public Order order{get; set;}

    public OrderExcelController(ApexPages.StandardController stdController) {
        order = (Order) stdController.getRecord();
    }
}