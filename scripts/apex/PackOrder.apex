// Pack Order Products script
// Run with: sf apex run --file scripts/apex/PackOrder.apex

Id orderId = '801gK00000P2LZqQAN';

// Query the Order with its OrderItems and related Product2 fields
Order order1 = [
    SELECT Id,
           OrderNumber,
           TotalAmount,
           (SELECT Id,
                   Product2Id,
                   Product2.Name,
                   Quantity,
                   UnitPrice
            FROM OrderItems)
    FROM Order
    WHERE Id = :orderId
    LIMIT 1
];

// Log basic order details
System.debug('Order Details: ' + order1);

// Serialize to JSON (pretty)
String packed = JSON.serializePretty(order1);
System.debug('Order JSON: ' + packed);
