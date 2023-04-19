// Used JSON Serialization Documentation Example as a template:
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_json_json.htm

public class JsonSerializeSample {
  
    public class FlightEstRequest {
        String type;
        String distance_unit;
        Integer passengers;
        List<Object> legs;

        public FlightEstRequest(Integer p, List<String> iata, Boolean roundTrip){
            type = 'flight';
            distance_unit = 'mi';
            passengers = p;
            legs = new List<Object>();
            
            // Legs variable is populated using the following for loop.
            for (Integer x=0; x<iata.size()-1; x++) {
                Map<String,String> eachleg = new Map<String,String>();

                eachleg.put('departure_airport', iata[x]);
                eachleg.put('destination_airport', iata[x+1]);

                legs.add(eachleg);
            }
            
            // If this flight is marked as roundtrip, this for loop populates the roundtrip legs for Legs variable. 
            if(roundtrip == true){
                for (Integer x=iata.size()-1; x>0; x--) {
                    Map<String,String> eachleg = new Map<String,String>();

                    eachleg.put('departure_airport', iata[x]);
                    eachleg.put('destination_airport', iata[x-1]);

                    legs.add(eachleg);
                }
        	}
   		}	
    }
    
    public static void SerializeBody(Integer p, List<String> iata, Boolean roundTrip) {
        //Instantiate a new FlightEstRequest list to serialize.               
        FlightEstRequest generatedRequest = new FlightEstRequest(p, iata, roundTrip);

        // Serialize the list of FlightEstRequest objects.
        String JSONString = JSON.serialize(generatedRequest);
        System.debug(JSONString);
    }
}