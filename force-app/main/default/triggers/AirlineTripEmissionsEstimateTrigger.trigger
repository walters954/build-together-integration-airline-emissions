trigger AirlineTripEmissionsEstimateTrigger on Airline_Trip_Emissions_Estimate__c (before insert) {
    for(Airline_Trip_Emissions_Estimate__c newATEE : Trigger.new){
        if(String.isEmpty(newATEE.Transaction_ID__c) && newATEE.Request_Date_Time__c == null){
            System.debug('>>>>> Record created directly by user (not using screen flow).');
        }
        else {
            System.debug('>>>>> Record created using screen flow.');
        }
    }
}