//
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// code by Neil Hohmann
// 

public with sharing class AirlineTripEmissionsTriggerHandler {
    public static List<Airline_Trip_Emissions_Estimate__c> ATEEsToProcess = new List<Airline_Trip_Emissions_Estimate__c>();
    public static List<String> airportCodes = new List<String>();

    public static void beforeInsert(List<Airline_Trip_Emissions_Estimate__c> newATEEs){
        for(Airline_Trip_Emissions_Estimate__c newATEE : newATEEs){
            if(String.isEmpty(newATEE.Transaction_ID__c) && newATEE.Request_Date_Time__c == null){
                ATEEsToProcess.add(newATEE);
            }
        }
        if (ATEEsToProcess.size() > 0){
            // Here I'm not passing ATEEsToProcess since I assume it will already be accessible in prepareCallout()
            for(Airline_Trip_Emissions_Estimate__c nextATEE : ATEEsToProcess){
                defineAirports(nextATEE);
                createWrapper(nextATEE);
            }
        }
    }

    public static void defineAirports(Airline_Trip_Emissions_Estimate__c nextATEE){
        airportCodes.add(String.valueOf(nextATEE.Origination_Airport__c));
        if (nextATEE.Layover_Airport__c != null){          
            airportCodes.add(String.valueOf(nextATEE.Layover_Airport__c));   
        }
        airportCodes.add(String.valueOf(nextATEE.Final_Destination_Airport__c));
        System.debug('airportCodes: ' + airportCodes);
    }


    public static void createWrapper(Airline_Trip_Emissions_Estimate__c nextATEE){
        CarbonBodyWrapper wrapper = new CarbonBodyWrapper();
        wrapper.type          = 'flight';
        wrapper.passengers    = nextATEE.Number_of_Passengers__c.intValue();
        wrapper.legs          = CarbonRequestSender.processLegs(airportCodes, nextATEE.Round_Trip__c);
        wrapper.distance_unit = 'mi';
        System.debug('wrapper: ' + wrapper);
        System.debug('Legs: ' + CarbonRequestSender.displayLegs);
    }
}