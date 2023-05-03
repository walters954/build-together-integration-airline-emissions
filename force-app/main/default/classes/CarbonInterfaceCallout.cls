public class CarbonInterfaceCallout {
    public String type;
    public Integer passengers;
    public List<Legs> legs;
    public String distance_unit;
    public String departure_airport;
    public String destination_airport;

    public class Legs {
        public String departure_airport;
        public String destination_airport;
    }

    // Constructor
    public CarbonInterfaceCallout(String type, Integer passengers, String departure_airport, String destination_airport, String distance_unit, List<Legs> legs) {
        this.type = type;
        this.passengers = passengers;
        this.departure_airport = departure_airport;
        this.destination_airport = destination_airport;
        this.distance_unit = distance_unit;
        this.legs = legs;
        
        Legs legA = new Legs();
        legA.departure_airport = departure_airport;
        legA.destination_airport = destination_airport;
        legs.add(legA);

        Legs legB = new Legs();
        legB.departure_airport = destination_airport;
        legB.destination_airport = departure_airport;
        legs.add(legB);

        //Create an Instance of the Wrapper Class
        CarbonInterfaceRequestWrapper wrapper = new CarbonInterfaceRequestWrapper();
        List<CarbonInterfaceRequestWrapper.Legs> legsList = new List<CarbonInterfaceRequestWrapper.Legs>();
        CarbonInterfaceRequestWrapper.Legs leg1 = new CarbonInterfaceRequestWrapper.Legs();
        leg1.departure_airport = departure_airport;
        leg1.destination_airport = destination_airport;
        legsList.add(leg1);

        CarbonInterfaceRequestWrapper.Legs leg2 = new CarbonInterfaceRequestWrapper.Legs();
        leg2.departure_airport = destination_airport;
        leg2.destination_airport = departure_airport;
        legsList.add(leg2);

        wrapper.type = type;
        wrapper.passengers = passengers;
        wrapper.distance_unit = distance_unit;
        wrapper.legs = legsList;

        sendRequest(wrapper); // Call the sendRequest method passing the wrapper object
    }

    public static void sendRequest(CarbonInterfaceRequestWrapper wrapper) {
        // Prepare Http Request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Carbon_Interface_Callout');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setMethod('POST');
        String reqBody = JSON.serialize(wrapper);
        req.setBody(reqBody);

        // Create Http Object
        Http http = new Http();

        // Response object
        HttpResponse response = http.send(req);
        system.debug(response);
        system.debug(response.getBody());
        getResponse(response); // Passing the response in the getResponse method
        }

        // Get Response in Salesforce
    public static void getResponse(HttpResponse response) {
        // if the request is successful parse the JSON response
        if (response.getStatusCode() == 201) {
            // Deserializing the JSON Response
            CarbonInterfaceResponseWrapper responseWrapper = CarbonInterfaceResponseWrapper.parse(response.getBody());
            System.debug('response id: ' + responseWrapper.data.id);
            System.debug('response type: ' + responseWrapper.data.type);
            System.debug('response passengers: ' + responseWrapper.data.attributes.passengers);
            System.debug('response distance_value: ' + responseWrapper.data.attributes.distance_value);
            System.debug('response distance_unit: ' + responseWrapper.data.attributes.distance_unit);
            System.debug('response estimated_at: ' + responseWrapper.data.attributes.estimated_at);
            System.debug('response carbon_g: ' + responseWrapper.data.attributes.carbon_g);
            System.debug('response carbon_lb: ' + responseWrapper.data.attributes.carbon_lb);
            System.debug('response carbon_kg: ' + responseWrapper.data.attributes.carbon_kg);
            System.debug('response carbon_mt: ' + responseWrapper.data.attributes.carbon_mt);
            
            // Access the legs list and its properties
            List<CarbonInterfaceResponseWrapper.Legs> legsList = responseWrapper.data.attributes.legs;
            for (CarbonInterfaceResponseWrapper.Legs leg : legsList) {
    
                String departureAirport = leg.departure_airport;
                String destinationAirport = leg.destination_airport;
                system.debug('Departure Airport: ' + departureAirport);
                system.debug('Destination Airport: ' + destinationAirport);
            }
             
           
        }
    }
}
