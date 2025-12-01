// Pack Order Products

Id orderId = '801gK00000P2LZqQAN';

Order order1 = [SELECT Id, OrderNumber, TotalAmount, (SELECT Id, Product2Id, Product2.Name, Quantity, UnitPriceFROM OrderItems) FROM Order WHERE Id = :orderId
]

System.debug('Order Details: ' + order1);

String packed = JSON.serializePretty(order1);
System.debug('Order JSON: ' + packed);