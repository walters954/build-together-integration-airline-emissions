public class AirlineWrapper {

    public String type { get; set; }
    public Integer passengers { get; set; }
    public List<Leg> legs { get; set; }
    public String distance_unit { get; set; }

    public class Leg {
        // IATA code
        public String departure_airport { get; set; }
        // IATA code
        public String destination_airport { get; set; }
        // economy or premium (optional)
        public String cabin_class { get; set; }

        public Leg(String departure_airport, String destination_airport, String cabin_class) {
            this.departure_airport = departure_airport;
            this.destination_airport = destination_airport;
            this.cabin_class = cabin_class;
        }

        public Leg(String departure_airport, String destination_airport) {
            this(departure_airport, destination_airport);
        }

        private Boolean isLegValid() {
            if(String.isBlank(this.departure_airport) || String.isBlank(this.destination))
        }

    }

    public AirlineWrapper() {
        // constructor
        // this is where you can initialize your class
    }

    public AirlineWrapper(String argument) {

    }

    public AirlineWrapper(List<String> arguments) {

    }

}