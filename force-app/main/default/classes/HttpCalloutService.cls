public with sharing class HttpCalloutService {
    public static Map<String, Object> callout(
        String method,
        String endpoint,
        Map<String, String> headers,
        String reqBody
    ){
        HttpRequest request = new HttpRequest();

        request.setEndpoint(endpoint);
        request.setMethod(method);
        
        // Set headers
        if(headers != null){
            for(String key : headers.keySet()){
                request.setHeader(key, headers.get(key));
            }
        }
        
        // Set body
        if(reqBody != null){
            request.setBody(reqBody);
        }
        
        Http http = new Http();
        HttpResponse response;
        
        Integer statusCode;
        String responseBody;
        String errorMessage;

        try{
            response = http.send(request);

            statusCode = response.getStatusCode();
            responseBody = response.getBody();
        } 
        catch(Exception e){
            errorMessage = e.getMessage();
        }
        
        Map<String, Object> result = new Map<String, Object>();
        result.put('statusCode', statusCode);
        result.put('responseBody', responseBody);
        result.put('errorMessage', errorMessage);

        return result;
    }
}