public class CarbonInterfaceCallout {
    private final String API_BASE_URL = CarbonInterfaceConstants.API_BASE_URL;
    private final String API_KEY = CarbonInterfaceConstants.API_KEY;

    public HttpResponse makeCarbonRequest(String endpoint, String httpMethod, Map<String, String> headers, String requestBody) {
        // Build the request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_BASE_URL + endpoint);
        request.setMethod(httpMethod);
        request.setHeader(CarbonInterfaceConstants.API_TOKEN_HEADER, CarbonInterfaceConstants.API_TOKEN_PREFIX + ' ' + API_KEY);
        for (String header : headers.keySet()) {
            request.setHeader(header, headers.get(header));
        }
        request.setBody(requestBody);
        
        // Send the request and return the response
        Http http = new Http();
        HttpResponse response = http.send(request);
        return response;
    }
}