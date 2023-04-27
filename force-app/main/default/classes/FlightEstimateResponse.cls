public class FlightEstimateResponse {
    public List<Leg> legs;
    public List<Passenger> passengers;
    public Integer distance_value;
    public String distance_unit;
   
    public Decimal carbon_g;
    public Decimal carbon_lb;
    public Decimal carbon_kg;
    public Decimal carbon_mt;


public class Leg {
    public String departureAirport;
    public String destinationAirport;
    public Decimal distanceUnit;
    public String distance;
}

public class Passenger {
    public String name;
    public Decimal weight;
    public String gender;
}
}
