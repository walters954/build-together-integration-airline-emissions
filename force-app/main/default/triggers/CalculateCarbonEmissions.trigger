trigger CalculateCarbonEmissions on FlightEstimate__c (after insert, after update) {
    for (FlightEstimate__c estimate : Trigger.new) {
        if (estimate.Departure_Airport__c == null || estimate.Destination_Airport__c == null || estimate.Date_of_travel__c == null) {
            continue; // Exit the loop if any required fields are missing
        }
        
        CarbonInterfaceCallout callout = new CarbonInterfaceCallout();
        FlightEstimateResponse__c response = callout.getCarbonEmissions(estimate);
        
        insert response;
    }
}
