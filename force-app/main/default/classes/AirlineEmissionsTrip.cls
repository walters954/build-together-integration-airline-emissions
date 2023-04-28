//
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// Team 2: team-EMEA
// 


public class AirlineEmissionsTrip {
    public static String idToReturnToFlow;

    public static void createAteeObject(List<String> airportCodes, String legsToDisplay, Boolean roundtrip, CarbonResponseWrapper response) {
        Airline_Trip_Emissions_Estimate__c currentATEE = new Airline_Trip_Emissions_Estimate__c();
        
        String originationAirport      = airportCodes.get(0);
        String finalDestinationAirport = airportCodes.get(airportCodes.size()-1);

        // Create Flight Details fields >> all captured in Flow
        currentATEE.Number_of_Legs__c            = response.data.attributes.legs.size();
        currentATEE.Legs__c                      = legsToDisplay;
        currentATEE.Origination_Airport__c       = originationAirport;
        currentATEE.Final_Destination_Airport__c = finalDestinationAirport;
        currentATEE.Number_of_Passengers__c      = response.data.attributes.passengers;
        currentATEE.Round_Trip__c                = roundtrip;
        currentATEE.Non_Stop_Flight__c           = TRUE;


        if (airportCodes.size() == 3){
            String layoverAirport = airportCodes.get(1);
            // Set Layover Airport and uncheck Non-Stop Flight
            currentATEE.Layover_Airport__c = layoverAirport;
            currentATEE.Non_Stop_Flight__c = FALSE;
        }

        // Create Carbon Interface Emissions Data fields
        currentATEE.Request_Date_Time__c = Datetime.valueOf(response.data.attributes.estimated_at.replace('T',' ')).addHours(2);
        currentATEE.Transaction_ID__c    = response.data.id;
        currentATEE.Flight_Distance__c   = response.data.attributes.distance_value;
        currentATEE.Distance_Unit__c     = response.data.attributes.distance_unit;
        currentATEE.CO2e_lb__c           = response.data.attributes.carbon_lb;
        currentATEE.CO2e_kg__c           = response.data.attributes.carbon_kg;
        currentATEE.CO2e_mt__c           = response.data.attributes.carbon_mt;

        Insert currentATEE;

        idToReturnToFlow = currentATEE.Id;
    }
}