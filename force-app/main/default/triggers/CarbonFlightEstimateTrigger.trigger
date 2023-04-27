trigger CarbonFlightEstimateTrigger on CarbonFlightEstimate__c (before insert, after insert) {

    if(Trigger.isBefore) {
        if(Trigger.isInsert) {

        }
        if(Trigger.isUpdate) {

        }
    }
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            
            List<String> airportCodes = new List<String>();
            airportCodes.add('MIA');
            airportCodes.add('FLL');
            CarbonInterfaceCalloutPost.makePostCallout(12, airportCodes, false);
        }
        if(Trigger.isUpdate) {
            
        }
    }

}

