//
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// Team 2: team-EMEA
// 

public class CarbonRequestSender {
    static List<String> displayLegs = new List<String>(); // used when displaying flight/emission data
    static final String TOKEN = '3jeEa9IauqaGb0ZDTsxw';

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
            // Adds return airport codes to airports[]
            // ['PHL', 'ORD', 'SEA'] >>> ['PHL', 'ORD', 'SEA', 'ORD', 'PHL']
            for(Integer i=airports.size()-2; i>=0; i--){
                airports.add(airports.get(i));
            }
        }
        // Creates each leg of journey (including any return trip)
        List<CarbonBodyWrapper.Leg> legs = new List<CarbonBodyWrapper.Leg>();
        for(Integer i=0;i<airports.size()-1;i++){
            //create leg
            CarbonBodyWrapper.Leg leg = new CarbonBodyWrapper.Leg();
            leg.departure_airport   = airports.get(i);
            leg.destination_airport = airports.get(i+1);
            legs.add(leg);
            //add airport leg (eg, 'PHL > ORD') to displayLegs[] to display later
            displayLegs.add(airports.get(i) + ' > ' + airports.get(i+1));
        }
        return legs;
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
        String dateRun = carbonBodyResponse.data.attributes.estimated_at;
        String distanceUnit = carbonBodyResponse.data.attributes.distance_unit;

        System.debug('>>>>> Carbon Interface API - Airline Emissions');
        System.debug('>>>>> Request Date/Time: ' + Datetime.valueOf(dateRun.replace('T',' ')).addHours(2).format());
        System.debug('>>>>> Number of Passengers: ' + carbonBodyResponse.data.attributes.passengers);
        System.debug('>>>>> Number of legs: ' + carbonBodyResponse.data.attributes.legs.size());
        for(String leg : displayLegs){
            System.debug('>>>>> ' + leg);
        }
        System.debug('>>>>> Total distance (' + distanceUnit + '): ' + carbonBodyResponse.data.attributes.distance_value);
        System.debug('>>>>> CO2e lb: ' + carbonBodyResponse.data.attributes.carbon_lb);
        System.debug('>>>>> CO2e kg: ' + carbonBodyResponse.data.attributes.carbon_kg);
        System.debug('>>>>> CO2e mt: ' + carbonBodyResponse.data.attributes.carbon_mt);
    }
}