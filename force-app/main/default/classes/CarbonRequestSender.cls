//
// Code by Neil Hohmann
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// Team 2: team-EMEA
//

public class CarbonRequestSender {
    static List<String> airportLegs = new List<String>(); // to display individual legs (PHL > SEA) with response data

    public static void prepareRequest(Integer numPassengers, List<String> airports, Boolean roundtrip, String distanceUnit){
        CarbonBodyWrapper wrapper = new CarbonBodyWrapper();
        wrapper.type = 'flight';
        wrapper.passengers = numPassengers;
        wrapper.distance_unit = distanceUnit;
        wrapper.legs = processLegs(airports, roundtrip);
        sendRequest(wrapper);
    }

    public static List<CarbonBodyWrapper.Leg> processLegs(List<String> airports, Boolean roundtrip){
        // Check for roundtrip & add airport codes accordingly
        if(roundtrip){
            List<String> clone = airports.clone();
            Integer n = airports.size();
            for(Integer i=n-2; i>=0; i--){
                airports.add(clone.get(i));
            }
        }
        // Create each leg of journey (including return trip)
        List<CarbonBodyWrapper.Leg> legs = new List<CarbonBodyWrapper.Leg>();
        for(Integer i=0;i<airports.size()-1;i++){
            //create leg
            CarbonBodyWrapper.Leg leg = new CarbonBodyWrapper.Leg();
            leg.departure_airport = airports.get(i);
            leg.destination_airport = airports.get(i+1);
            legs.add(leg);
            //add airport leg (eg, PHL > ORD) to airportLegs
            airportLegs.add(airports.get(i) + ' > ' + airports.get(i+1));
        }
        System.debug('>>>>> Legs: ' + airportLegs);
        return legs;
    }

    public static void sendRequest(CarbonBodyWrapper wrapper) { 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        req.setHeader ('Authorization', 'Bearer 3jeEa9IauqaGb0ZDTsxw');
        req.setMethod ('POST');
        req.setHeader ('Content-Type', 'application/json');
        
        // Serialize the wrapper object as JSON and set it as the request body
        String requestBody = JSON.serialize(wrapper);
        req.setBody(requestBody);

        // Print the request body to the debug log
        System.debug('Created JSON body: ' + requestBody);
         
        // Create HTTP & HttpResponse objects and send the request
        Http httpCallout = new Http();
        HttpResponse carbonResponse = httpCallout.send(req);
        
        // Pass response to processResponse method
        processResponse(carbonResponse);
    }

    public static void processResponse(HttpResponse carbonResponse){
        
        // Print response to the debug log
        System.debug(carbonResponse.getBody());

        // Deserialize the response using the parse method of the CarbonResponseWrapper class
        CarbonResponseWrapper carbonBodyResponse = CarbonResponseWrapper.parse(carbonResponse.getBody());
        
        // Print data to output console
        String airport1 = carbonBodyResponse.data.attributes.legs.get(0).departure_airport;
        String airport2 = carbonBodyResponse.data.attributes.legs.get(0).destination_airport;
        Integer numlegs = carbonBodyResponse.data.attributes.legs.size();
        String dateProcessed = carbonBodyResponse.data.attributes.estimated_at;

        System.debug('>>>>> Carbon Interface API - Airline Emissions');
        System.debug('>>>>> Request Date/Time: ' + Datetime.valueOf(dateProcessed.replace('T',' ')).addHours(2).format());
        System.debug('>>>>> Number of Passengers: ' + carbonBodyResponse.data.attributes.passengers);
        // Idea: use loop to loop over legs (using .size() and give dep/des airport codes.
        System.debug('>>>>> Number of legs: ' + numLegs);
        for(String airportLeg : airportLegs){
            System.debug(airportLeg);
        }
        System.debug('>>>>> Total distance (' + carbonBodyResponse.data.attributes.distance_unit + '): ' + carbonBodyResponse.data.attributes.distance_value);
        System.debug('>>>>> CO2e lb: ' + carbonBodyResponse.data.attributes.carbon_lb);
        System.debug('>>>>> CO2e kg: ' + carbonBodyResponse.data.attributes.carbon_kg);
        System.debug('>>>>> CO2e mt: ' + carbonBodyResponse.data.attributes.carbon_mt);
    }
}