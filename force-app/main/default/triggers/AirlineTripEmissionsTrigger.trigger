//
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// code by Neil Hohmann
// 

trigger AirlineTripEmissionsTrigger on Airline_Trip_Emissions_Estimate__c (after insert) {
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            AirlineTripEmissionsTriggerHandler.afterInsert(Trigger.new);
        }
    }
}