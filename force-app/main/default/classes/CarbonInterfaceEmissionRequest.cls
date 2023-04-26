public class CarbonInterfaceEmissionRequest {
    
    private String type;
    private String distance_unit;
    private Integer passengers;
    private List <Leg> legs;

    public CarbonInterfaceEmissionRequest() {

    }

     public CarbonInterfaceEmissionRequest(String type, 
            String distance_unit , Integer passengers, List <Leg> legs) {
        this.type = type;
        this.distance_unit = distance_unit;
        this.passengers = passengers;
        this.legs = legs;
        validateRequest();
    }

    public CarbonInterfaceEmissionRequest(Leg departureTrip, Boolean isReturnTrip) {
    this.type = 'flight';
    this.distance_unit = 'mi';
   
  //  this.legs = legs;
    this.passengers = 1;
    Leg returnTrip = new Leg(departureTrip.departure_airport, departureTrip.destination_airport);
    this.legs = new List<Leg> {departureTrip, returnTrip};

    }

    public Boolean validateRequest(){
        Boolean isRequestValid =true;
        if (this.passengers <=0){

            isRequestValid= false;
            //throw new Exception('passengers cannot be negative ');
         }
         return isRequestValid;
    }

    public class Leg{
        public String departure_airport;
        public String destination_airport;

        public Leg(String departure_airport, String destination_airport){
            this.departure_airport = departure_airport;
            this.destination_airport= destination_airport;
        }
    }

}