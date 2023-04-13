public with sharing class CarbonCallout {
    public static void makeAPICallout() {
        // Create a new HTTP object
        Http http = new Http();
        
        // Create a new HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        
        // Send the HTTP request and receive the response
        HttpResponse response = http.send(request);
        
        // Handle the response data
        if (response.getStatusCode() == 200) {
            String responseBody = response.getBody();
            // Do something with the response body, such as parsing it with JSON.deserialize()
        } else {
            // Handle the error response
            String errorMessage = 'API request failed with status code ' + response.getStatusCode() + ': ' + response.getStatus();
            // Handle the error as appropriate, such as logging it or displaying an error message to the user
        }
    }
}