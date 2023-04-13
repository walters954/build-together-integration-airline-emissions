public class CarbonInterfaceCalloutPost {
    public static HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer Ak39L8xTeFMVNA7tAFcd9Q');
        request.setBody('{"type":"flight","passengers":200,"legs":[{"departure_airport":"rdu","destination_airport":"cdg"}]}');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The status code returned was as expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug('This is the response from Carbon Interface: ' + response.getBody());
        }
        
        return response;
    }        
}