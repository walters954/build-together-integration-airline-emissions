global class SendCarbonWrapper {
    static final String TOKEN = 'ReTplXf0CLPlh9AhujJ6Ow';
    private static final String carbonURL = 'https://www.carboninterface.com/api/v1/estimates';
    private static final String Post = 'POST';
    private static List<CarbonWrapperClass.Leg> legs = new List<CarbonWrapperClass.leg>();

    public static void getEmissionsData(){
       
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(carbonURL);
        request.setMethod(POST);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization', 'Bearer ' + TOKEN);
        
        //Create wrapper body
        CarbonWrapperClass wrapper = new CarbonWrapperClass();
        wrapper.type = 'flight';
        wrapper.passengers = 2;
        wrapper.distance_unit = 'km';
        
        CarbonWrapperClass.Leg leg1 = new CarbonWrapperClass.Leg();
        leg1.departure_airport = 'MIA';
        leg1.destination_airport = 'LAX';

        CarbonWrapperClass.Leg leg2 = new CarbonWrapperClass.Leg();
        leg2.departure_airport = 'LAX';
        leg2.destination_airport = 'MIA'; 
        
        legs.add(leg1);
        legs.add(leg2);
        wrapper.legs = legs;

        //serialize the wrapper body
        String body = JSON.serialize(wrapper);
        request.setBody(body);

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
