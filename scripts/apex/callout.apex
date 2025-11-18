String method = 'GET';
String endpoint = 'https://jsonplaceholder.typicode.com/posts/1';
String bodyObj= 'badi';

HttpRequest req = new HttpRequest();
req.setMethod(method);
req.setEndpoint(endpoint);
req.setHeader('Content-Type', 'application/json');
req.setBody(JSON.serializePretty(bodyObj));

Http http = new Http();
HTTPResponse res = http.send(req);

System.debug('Response Body: ' + res.getBody());
System.debug('Response Status Code: ' + res.getStatusCode());