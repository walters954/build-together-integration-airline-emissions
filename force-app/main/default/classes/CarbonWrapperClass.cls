public class CarbonWrapperClass {

	public class Legs {
		public String departure_airport;
		public String destination_airport;
	}

	public String type;
	public Integer passengers;
	public List<Legs> legs;

	
	public static CarbonWrapperClass parse(String json) {
		return (CarbonWrapperClass) System.JSON.deserialize(json, CarbonWrapperClass.class);
	}
}