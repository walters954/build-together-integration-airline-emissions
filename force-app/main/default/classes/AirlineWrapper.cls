public class AirlineWrapper {
	
    public Data data;

    public class Data {
		@AuraEnabled public String id;
		@AuraEnabled public String type;
		@AuraEnabled public Attributes attributes;
	}

    public class Attributes {
		@AuraEnabled public Integer passengers;
		@AuraEnabled public List<Legs> legs;
		@AuraEnabled public Datetime estimatedAt;
		@AuraEnabled public Integer carbonG;
		@AuraEnabled public Double carbonLb;
		@AuraEnabled public Double carbonKg;
		@AuraEnabled public Double carbonMt;
		@AuraEnabled public String distanceUnit;
		@AuraEnabled public Double distanceValue;
	}

	public class Legs {
		@AuraEnabled public String departureAirport;
		@AuraEnabled public String destinationAirport;
	}

	public static AirlineWrapper parse(String json) {
		return (AirlineWrapper) System.JSON.deserialize(json, AirlineWrapper.class);
	}
}