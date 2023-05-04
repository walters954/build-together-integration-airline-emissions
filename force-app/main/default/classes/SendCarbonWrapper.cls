global class SendCarbonWrapper {
    static final String TOKEN = 'ReTplXf0CLPlh9AhujJ6Ow';
    private static final String carbonURL = 'https://www.carboninterface.com/api/v1/estimates';
    private static final String Post = 'POST';

    public static List<CarbonWrapperClass.Legs> getEmissionsData(){
        List<CarbonWrapperClass.Legs> emissionsData = new List<CarbonWrapperClass.Legs>();
       
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(carbonURL);
        request.setMethod(POST);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization', 'Bearer ' + TOKEN);

        //Send the HTTP request and get the response.
        HttpResponse response = http.send(request);
        CarbonWrapperClass emissionsDataResponse = CarbonWrapperClass.parse(response.getBody());
    for (CarbonWrapperClass.Legs leg : emissionsDataResponse.legs) {
        emissionsData.add(leg);
       
    }

        System.debug(emissionsDataResponse.type);
        System.debug(emissionsDataResponse.passengers);
        System.debug(emissionsDataResponse.legs);
        
        return emissionsData;
}
}
