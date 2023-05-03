global class SendCarbonEmission {
    static final String TOKEN = 'ReTplXf0CLPlh9AhujJ6Ow';

    public static void makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"type": "flight","passengers": 2,"legs": [{"departure_airport": "lax", "destination_airport": "mia"},{"departure_airport": "yyz", "destination_airport": "sfo"}]}');
        // Add the token to the header of the request
        request.setHeader('Authorization', 'Bearer ' + TOKEN);
        //Send the HTTP request and get the response.
        HttpResponse response = http.send(request);
        //Parse the JSON response. 
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }
}