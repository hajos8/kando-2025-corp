@isTest
private class HttpCalloutServiceTest {
    private class SuccessMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success","data":{"message":"Hello, World!"}}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testMockBehavior() {
        Map<String, String> headers = new Map<String, String>();
        headers.put('Content-Type', 'application/json');

        SuccessMock mock = new SuccessMock();
        Test.setMock(HttpCalloutMock.class, mock);
        Map<String, Object> response = HttpCalloutService.callout(
            'GET',
            'https://kkando.hu',
            headers,
            null
        );
    }

    @isTest
    static void errorTestMockBehavior() {
        Map<String, String> headers = new Map<String, String>();
        headers.put('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, new SuccessMock());
        Map<String, Object> response = HttpCalloutService.callout(
            'GET',
            'https://invalid.url.test',
            headers,
            null
        );
    }
}