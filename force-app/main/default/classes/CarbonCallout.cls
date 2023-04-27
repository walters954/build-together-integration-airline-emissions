public class CarbonCallout {
    
    @InvocableMethod(label='Get Carbon Emissions')
    public static List<FlightEstimateResponse__c> getCarbonEmissions(List<Flight_Estimate__c> estimates) {
        String endpoint = 'https://carboninterface.com/api/v1/estimates';
       
        
        
        List<FlightEstimateResponse__c> responses = new List<FlightEstimateResponse__c>();
        
        for(Flight_Estimate__c estimate : estimates) {
            if (estimate.Departure_Airport__c == null || estimate.Destination_Airport__c == null || estimate.Date_of_travel__c == null) {
                continue;
            }
            
            Map<String, Object> requestBody = new Map<String, Object>();
            requestBody.put('passenger', estimate.Passenger__c);
            
            List<Map<String, Object>> legs = new List<Map<String, Object>>();
            for(Leg__c leg : estimate.Leg__r) {
                Map<String, Object> legMap = new Map<String, Object>();
                legMap.put('departureAirport', leg.Departure_Airport__r.IATA_Code__c);
                legMap.put('destinationAirport', leg.Destination_Airport__r.IATA_Code__c);
                legMap.put('distance', leg.Distance__c);
                legMap.put('passenger', estimate.Passenger__c);
                legs.add(legMap);
            }
            requestBody.put('legs', legs);
            
            String requestBodyJson = JSON.serialize(requestBody);
            
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer ' + authToken);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(requestBodyJson);
            request.setTimeout(120000);
            
            HttpResponse response = null;
            
            
            if(response != null) {
                String responseBody = response.getBody();
                FlightEstimateResponse__c flightResponse = (FlightEstimateResponse__c) JSON.deserialize(responseBody, FlightEstimateResponse__c.class);
                if(flightResponse != null) {
                    flightResponse.Flight_Estimate__c = estimate.Id;
                    responses.add(flightResponse);
                }
            }
        }
        
        return responses;
    }
}
