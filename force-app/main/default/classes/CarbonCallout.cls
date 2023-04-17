public with sharing class CarbonCallout {

    static String TOKEN = '4cnGRtVDOW276krYYDTpA';


    public CarbonCallout() {

    }
    public static void callout2()
    {
        System.debug('hello');

    }

    public static void callout()
    {
        System.debug('CarbonCallout callout()');
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
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());
        System.debug(response.getBody());


    }
    
}