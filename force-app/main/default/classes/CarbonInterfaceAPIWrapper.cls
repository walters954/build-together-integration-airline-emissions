public class CarbonInterfaceAPIWrapper {
    CarbonInterfaceAPIWrapper apiWrapper = new CarbonInterfaceAPIWrapper();

    public static CarbonInterfaceCallout carbonInterfaceCallout = new CarbonInterfaceCallout();
    
    public  HttpResponse createFlightEstimate(List<Passenger> passengers, List<Leg> legs) {
        // Check if input parameters are valid
        if (passengers == null || passengers.isEmpty() || legs == null || legs.isEmpty()) {
            throw new IllegalArgumentException('Invalid input parameters');
        }
        
        // Build the request body
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('passengers', passengers);
        requestBody.put('legs', legs);
        
        // Make the API request using the CarbonInterfaceCallout instance
        HttpResponse response = carbonInterfaceCallout.makeCarbonRequest('/estimates', 'POST', new Map<String, String>(), JSON.serialize(requestBody));
        
        // Handle the response and return the HttpResponse
        if (response.getStatusCode() == 200) {
            return response;
        } else {
            throw new CalloutException('API request failed with status code: ' + response.getStatusCode());
        }
    }
}
