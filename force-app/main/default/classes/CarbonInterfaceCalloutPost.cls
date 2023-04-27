public class CarbonInterfaceCalloutPost {
    public static void makePostCallout(Integer p, List<String> iata, Boolean roundTrip) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer Ak39L8xTeFMVNA7tAFcd9Q');
        // request.setBody('{"type":"flight","passengers":500,"legs":[{"departure_airport":"rdu","destination_airport":"cdg"}]}');
        request.setBody(CarbonInterfaceJsonSerialize.SerializeBody(p, iata, roundTrip));
        HttpResponse response = http.send(request);

        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The status code returned was as expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug('This is the response from Carbon Interface: ' + response.getBody());
        }
        //Check if Json response body can be passed.
        System.debug(CarbonInterfaceJsonDeserialize.parse(response.getBody()));
        //Pass Json response body to this method.
        CarbonFlightEstimate__c cfe = CarbonInterfaceJsonDeserialize.parse(response.getBody());
        //Check if record was received.
        System.debug(cfe);
        //Insert new record and check for DML execution or error.
        try {
            insert cfe;
            System.debug('DML was executed x number of times: ' + Limits.getDMLRows());
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' + e.getMessage());
        }
	}
}