//create HTTP Object
HTTP http  = new HTTP();
//Create HTTP Request Object
HTTPRequest request = new HTTPRequest();
//Set EndPoint
request.setEndpoint('callout:Carbon_Interface_Callout/api/v1/estimates');
//Set Header
request.setHeader('Content-Type', 'application/json;charset=UTF-8');
//Set Method POST
request.setMethod('POST');
//Set Body as a Json Object
string requestBody = '{"type": "flight","passengers": 2, "legs": [{"departure_airport": "sfo", "destination_airport": "yyz"},{"departure_airport": "yyz", "destination_airport": "sfo"}]}';
request.setBody(requestBody);
HttpResponse response = http.send(request);
//Parse JSON Response
if(response.getStatusCode() == 201) {
    System.debug('Expected Status: ' + response.getStatusCode() + ' ' + response.getStatus());
} else {
    System.debug(response.getBody());
}