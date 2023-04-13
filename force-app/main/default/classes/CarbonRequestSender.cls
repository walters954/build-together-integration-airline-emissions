//
// Code by Neil Hohmann
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// Team 2: team-EMEA
//

public class CarbonRequestSender {
 
    public static void prepareRequest(Integer numPassengers, String airport1, String airport2, String distanceUnit){
        CarbonBodyWrapper wrapper = new CarbonBodyWrapper();
        wrapper.type = 'flight';
        wrapper.passengers = numPassengers;
        wrapper.distance_unit = distanceUnit;
        wrapper.legs = new List<CarbonBodyWrapper.Leg>{};
        // Create fist leg of trip (leg1)
        CarbonBodyWrapper.Leg leg1 = new CarbonBodyWrapper.Leg();
        leg1.departure_airport = airport1;
        leg1.destination_airport = airport2;
        // Create return leg (leg2)
        CarbonBodyWrapper.Leg leg2 = new CarbonBodyWrapper.Leg();
        leg2.departure_airport = airport2;
        leg2.destination_airport = airport1;
        // add each leg to legs (list)
        wrapper.legs.add(leg1);
        wrapper.legs.add(leg2);

        sendRequest(wrapper);
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
        String dateProcessed = carbonBodyResponse.data.attributes.estimated_at;

        System.debug('>>>>> Carbon Interface API - Airline Emissions');
        System.debug('>>>>> Request Date/Time: ' + Datetime.valueOf(dateProcessed.replace('T',' ')).addHours(2).format());
        System.debug('>>>>> Number of Passengers: ' + carbonBodyResponse.data.attributes.passengers);
        // Idea: use loop to loop over legs (using .size() and give dep/des airport codes.
        System.debug('>>>>> Number of legs: ' + carbonBodyResponse.data.attributes.legs.size());
        System.debug('>>>>> ' + airport1 + ' > ' + airport2);
        System.debug('>>>>> ' + airport2 + ' > ' + airport1);
        System.debug('>>>>> Total distance (' + carbonBodyResponse.data.attributes.distance_unit + '): ' + carbonBodyResponse.data.attributes.distance_value);
        System.debug('>>>>> CO2e lb: ' + carbonBodyResponse.data.attributes.carbon_lb);
        System.debug('>>>>> CO2e kg: ' + carbonBodyResponse.data.attributes.carbon_kg);
        System.debug('>>>>> CO2e mt: ' + carbonBodyResponse.data.attributes.carbon_mt);
    }
}

