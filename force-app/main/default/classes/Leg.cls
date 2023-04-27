public class Leg {
    public String departureAirport {get; set;}
    public String destinationAirport {get; set;}
    public String cabinClass {get; set;}
    public Decimal distance {get; set;}
    public String distanceUnit {get; set;}
    
    public Leg(String departureAirport, String destinationAirport, String cabinClass, Integer distance, String distanceUnit) {
        this.departureAirport = departureAirport;
        this.destinationAirport = destinationAirport;
        this.cabinClass = cabinClass;
        this.distance = distance;
        this.distanceUnit = distanceUnit;
    }

public String getDepartureAirport() {
    return this.departureAirport;
}

public String getDestinationAirport() {
    return this.destinationAirport;
}

public Decimal getDistance() {
    return this.distance;
}
}