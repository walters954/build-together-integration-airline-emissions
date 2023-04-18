public class AirlineWrapper {
	
    public Data data;

    public class Data {
		@AuraEnabled public String id;
		@AuraEnabled public String type;
		@AuraEnabled public Attributes attributes;
	}

	public class Attributes {
        public Integer passengers;
        public List<Legs> legs;
        public Datetime estimated_at;
        public Integer carbon_g;
        public Double carbon_lb;
        public Double carbon_kg;
        public Double carbon_mt;
        public String distance_unit;
        public Double distance_value;
    }

    public class Legs {
        public String departure_airport;
        public String destination_airport;
    }

	public static AirlineWrapper parse(String json) {
		return (AirlineWrapper) System.JSON.deserialize(json, AirlineWrapper.class);
	}
}