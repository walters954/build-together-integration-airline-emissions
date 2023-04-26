public with sharing class CarbonCallout {

    public static   String TOKEN = '4cnGRtVDOW276krYYDTpA';


    public CarbonCallout() {

    }
    public static void callout2()
    {
        System.debug('hello, this is only  a test , ** its test 3');

    }

    public static void callout()
    {
        System.debug('this is a test CarbonCallout callout()');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + TOKEN);
        request.setHeader('Content-Type', 'application/json');

        /*Map<String,Object> data = new Map<String,Object> {'type' => 'flight'};
        System.debug(JSON.serialize(data));
*/

        Map<String,Object> data = new Map<String,Object>();
        data.put('type','flight');
        data.put('passengers',2);
        data.put('distance_unit','mi');
        Map<String,Object> leg1 = new Map<String,Object>();
        leg1.put('departure_airport', 'VIE');
        leg1.put('destination_airport', 'OSL');

        Map<String,Object> leg2 = new Map<String,Object>();
        leg2.put('departure_airport', 'VIE');
        leg2.put('destination_airport', 'OSL');

        Map<String,Object> leg3 = new Map<String,Object>();
        leg3.put('departure_airport', 'JFK');
        leg3.put('destination_airport', 'VIE');
        

        data.put('legs', new List<Object>{leg1,leg2,leg3});
        /*System.debug(); */

       // Map<string,Object> leg3 = new Map<String,Object>();
       // leg3.put('dest')


        String JSONbody = JSON.serialize(data);
        request.setBody(JSONBody);
        HttpResponse res = http.send(request);
        AirlineWrapper flightEstimates = AirlineWrapper.parse(res.getBody());

        //System.debug(res.getStatusCode());
        //System.debug(response.getBody());


    }

    public static void  doCallout3(){

        System.debug('hello, this is only call out 3');
        String type = 'flight';
        String distance_unit = 'mi';
        Integer passengers = 2;
     
        List<CarbonInterfaceEmissionRequest.Leg> myLegs = new List<CarbonInterfaceEmissionRequest.Leg> ();

        CarbonInterfaceEmissionRequest.Leg leg1 = new CarbonInterfaceEmissionRequest.Leg('ATL','MIA');
        myLegs.add(leg1);

        CarbonInterfaceEmissionRequest data  = new CarbonInterfaceEmissionRequest(type, distance_unit, passengers, myLegs );

        
       // String body = JSON.serialize(data);

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + TOKEN);
        request.setHeader('Content-Type', 'application/json');
       // request.setBody(request);

        Http http = new Http();

        
        String JSONbody = JSON.serialize(data);
        request.setBody(JSONBody);
        HttpResponse response = http.send(request);

        System.debug(response.getStatusCode());
        System.debug(response.getBody());


    }
    
}