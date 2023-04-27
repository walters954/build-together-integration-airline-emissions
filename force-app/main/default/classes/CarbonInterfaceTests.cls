@isTest
public class FlightEstimateGeneratorTest {
    
    @testSetup
    static void testSetup() {
        // TODO: Add any test setup code here
    }
    
    @isTest
    static void testGenerateFlightEstimate() {
        // Create a new leg
        Leg leg = new Leg('JFK', 'LAX', 1000.0);
        
        // Create a new passenger
        Passenger passenger = new Passenger('Mary', 80.0, 'female');
        
        // Create a list of legs and passengers
        List<Leg> legs = new List<Leg>{leg};
        List<Passenger> passengers = new List<Passenger>{passenger};
        
        // Call the generateFlightEstimate method
        FlightEstimateGenerator generator = new FlightEstimateGenerator();
        FlightEstimate estimate = generator.generateFlightEstimate(legs, passengers);
        
        // Assert that the estimate is not null and has a valid ID
        System.assertNotEquals(null, estimate);
        System.assertNotEquals(null, estimate.Id);
    }
}
