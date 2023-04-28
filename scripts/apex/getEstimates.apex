//Create HTTP Object
Http http = new Http();

//Create HTTP Request Object
HttpRequest request = new HttpRequest();

//set Endpoint
request.setEndpoint('callout:Carbon_Interface_Callout');

//set Get Method
request.setMethod('GET');

//Create HTTP Response Object
HttpResponse response = http.send(request);
system.debug(response);
// If the request is successful, parse the JSON response.
if(response.getStatusCode() == 200) {
     system.debug(response.getBody());
    }
