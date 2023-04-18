public with sharing class CarbonCallout {

    private static final String CARBON_URL = 'https://www.carboninterface.com/api/v1/estimates';
    private static final String APIKEY = 'o9OkXzJnFSplmvgfEwCZw';

    //ToDo: receive a map from who is calling then deserialize
    @AuraEnabled 
    public static List<AirlineWrapper.Data> getFlightEstimateRequest(){
    //public static List<AirlineWrapper.Data> getFlightEstimateRequest(Map<String,Object> flightDetails){
        List<AirlineWrapper.Data> flightEstimatesWrapperData = new List<AirlineWrapper.Data>();

        Map<String,Object> data = new Map<String,Object>();
        data.put('type','flight');
        data.put('passengers',2);
        data.put('distance_unit','mi');
        Map<String,Object> leg1 = new Map<String,Object>();
        leg1.put('departure_airport', 'VIE');
        leg1.put('destination_airport', 'OSL');
        Map<String,Object> leg2 = new Map<String,Object>();
        leg2.put('departure_airport', 'OSL');
        leg2.put('destination_airport', 'VIE');
        data.put('legs', new List<Object>{leg1,leg2});
        
        String requestBodyJson = JSON.serialize(data);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(CARBON_URL);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + APIKEY);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(requestBodyJson);
        
        Http httpCallout = new Http();
        
        HTTPResponse res = httpCallout.send(req);
        AirlineWrapper flightEstimates = AirlineWrapper.parse(res.getBody());
        
        AirlineWrapper.Data flightEstimateData = new AirlineWrapper.Data();
        flightEstimateData.type = flightEstimates.data.type;
        flightEstimateData.id = flightEstimates.data.id;
        flightEstimateData.attributes = flightEstimates.data.attributes;
        flightEstimateData.attributes.passengers = flightEstimates.data.attributes.passengers;
        flightEstimateData.attributes.legs = flightEstimates.data.attributes.legs;
        flightEstimateData.attributes.distance_value = flightEstimates.data.attributes.distance_value;
        flightEstimateData.attributes.distance_unit = flightEstimates.data.attributes.distance_unit;
        flightEstimateData.attributes.estimated_at = flightEstimates.data.attributes.estimated_at;
        flightEstimateData.attributes.carbon_g = flightEstimates.data.attributes.carbon_g;
        flightEstimateData.attributes.carbon_lb = flightEstimates.data.attributes.carbon_lb;
        flightEstimateData.attributes.carbon_kg = flightEstimates.data.attributes.carbon_kg;        
        flightEstimateData.attributes.carbon_mt = flightEstimates.data.attributes.carbon_mt;
        
        flightEstimatesWrapperData.add(flightEstimateData);
        //System.debug('flightEstimatesWrapperData: ' + flightEstimatesWrapperData);
        return flightEstimatesWrapperData;
        
    }

}