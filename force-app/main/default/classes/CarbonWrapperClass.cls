public class CarbonWrapperClass {
	public String type;
	public Integer passengers;
	public List<Leg> legs;
	public String distance_unit;

	public class Leg {
		public String departure_airport;
		public String destination_airport;
	}

}