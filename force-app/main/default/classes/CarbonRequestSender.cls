//
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// code by Neil Hohmann
// 

global class CarbonRequestSender {
    static List<String> airportCodes = new List<String>();
    static Boolean returnTrip;
    public static String displayLegs = ''; // displays legs in page layout (UI)
    static final String TOKEN = '3jeEa9IauqaGb0ZDTsxw';


    @InvocableMethod(label='sendCarbonInterfaceRequest' callout=true)
    public static List<makeCarbonInterfaceResult> prepareRequest(List<makeCarbonInterfaceRequest> requests){
        List<makeCarbonInterfaceResult> results = new List<makeCarbonInterfaceResult>();

        for (makeCarbonInterfaceRequest request : requests){
            airportCodes = request.airports;
            returnTrip   = request.roundtrip;
            CarbonBodyWrapper wrapper = new CarbonBodyWrapper();
            wrapper.type           = 'flight';
            wrapper.passengers     = request.passengers.intValue();
            wrapper.distance_unit  = 'mi';
            wrapper.legs           = processLegs(airportCodes, returnTrip);

            // This starts a daisy-chain of method calls that results in a new ATEE record
            sendRequest(wrapper);
            
            // Capture and return the Id of the new ATEE record back to the flow
            makeCarbonInterfaceResult newResult = new makeCarbonInterfaceResult();
            newResult.newRecordId = AirlineEmissionsTrip.idToReturnToFlow;
            results.add(newResult);
        }
        return results;
    }

    global class makeCarbonInterfaceRequest {
        @InvocableVariable (required=true)
        global Decimal passengers;

        @InvocableVariable (required=true)
        global List<String> airports;

        @InvocableVariable (required=true)
        global Boolean roundtrip;
    }

    global class makeCarbonInterfaceResult {
        @InvocableVariable
        global String newRecordId;
    }

    public static List<CarbonBodyWrapper.Leg> processLegs(List<String> airports, Boolean roundtrip){
        List<CarbonBodyWrapper.Leg> legs = new List<CarbonBodyWrapper.Leg>();

        // Creates each outbound leg
        for(Integer i=0;i<airports.size()-1;i++){
            constructLeg(airports, legs, i, i+1);
        }
        // Creates each return leg
        if(roundtrip){
            for(Integer i=airports.size()-1; i>0; i--){
                constructLeg(airports, legs, i, i-1);
            }
        }
        
        // Creates string that will display legs in UI
        for (Integer i=0; i<legs.size(); i++){
            displayLegs += legs.get(i).departure_airport + ' > ' + legs.get(i).destination_airport;
            if (i != legs.size() -1){
                displayLegs += '\n';
            }
        }
        return legs;
    }


    public static void constructLeg(List<String> airports, List<CarbonBodyWrapper.Leg> legs, Integer depAirport, Integer destAirport){
        CarbonBodyWrapper.Leg leg = new CarbonBodyWrapper.Leg();
        leg.departure_airport   = airports.get(depAirport);
        leg.destination_airport = airports.get(destAirport);
        legs.add(leg);
    }
    
    public static void sendRequest(CarbonBodyWrapper wrapper) { 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        req.setHeader ('Authorization', 'Bearer ' + TOKEN);
        req.setMethod ('POST');
        req.setHeader ('Content-Type', 'application/json');
        
        // Serialize the wrapper object as JSON and set it as the request body
        String requestBody = JSON.serialize(wrapper);
        req.setBody(requestBody);

        System.debug('Created JSON body: ' + requestBody);
         
        // Create HTTP & HttpResponse objects and send the request
        Http httpCallout = new Http();
        HttpResponse carbonResponse = httpCallout.send(req);
        
        // Pass response to processResponse method
        processResponse(carbonResponse);
    }

    public static void processResponse(HttpResponse carbonResponse){
        
        System.debug('carbonResponse.getBody(): ' + carbonResponse.getBody());

        // Deserialize the response using the parse method of the CarbonResponseWrapper class
        CarbonResponseWrapper carbonBodyResponse = CarbonResponseWrapper.parse(carbonResponse.getBody());
        
        // Print data to output console
        String dateRun      = carbonBodyResponse.data.attributes.estimated_at;
        String distanceUnit = carbonBodyResponse.data.attributes.distance_unit;

        System.debug('>>>>> Carbon Interface API - Flight Emission Estimates');
        System.debug('>>>>> Transaction Id: '       + carbonBodyResponse.data.id);
        System.debug('>>>>> Request Date/Time: '    + Datetime.valueOf(dateRun.replace('T',' ')).addHours(2).format());
        System.debug('>>>>> Number of Passengers: ' + carbonBodyResponse.data.attributes.passengers);
        System.debug('>>>>> Number of legs: '       + carbonBodyResponse.data.attributes.legs.size());
        System.debug('>>>>> Legs: '                 + displayLegs);
        System.debug('>>>>> Total distance (' + distanceUnit + '): ' + carbonBodyResponse.data.attributes.distance_value);
        System.debug('>>>>> CO2e lb: ' + carbonBodyResponse.data.attributes.carbon_lb);
        System.debug('>>>>> CO2e kg: ' + carbonBodyResponse.data.attributes.carbon_kg);
        System.debug('>>>>> CO2e mt: ' + carbonBodyResponse.data.attributes.carbon_mt);

        AirlineEmissionsTrip.createAteeObject(airportCodes, displayLegs, returnTrip, carbonBodyResponse);
    }
}