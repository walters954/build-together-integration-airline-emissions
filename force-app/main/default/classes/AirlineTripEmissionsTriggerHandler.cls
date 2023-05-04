//
// April 2023
// Build Together Integration 4
// Carbon Interface API - Airline Emissions
// code by Neil Hohmann
// 

public with sharing class AirlineTripEmissionsTriggerHandler {
    static List<Airline_Trip_Emissions_Estimate__c> ATEEsToProcess = new List<Airline_Trip_Emissions_Estimate__c>();
    static List<String> airportCodes = new List<String>();
    static String wrapperJson;
    static String displayLegs;
    static String idToPass;

    public static void afterInsert(List<Airline_Trip_Emissions_Estimate__c> newATEEs){
        for(Airline_Trip_Emissions_Estimate__c newATEE : newATEEs){
            if(String.isEmpty(newATEE.Transaction_ID__c) && newATEE.Request_Date_Time__c == null){
                ATEEsToProcess.add(newATEE);
            }
        }

        if (ATEEsToProcess.size() > 0){
            for(Airline_Trip_Emissions_Estimate__c nextATEE : ATEEsToProcess){
                defineAirports(nextATEE);
                createWrapper(nextATEE);
            }
        }
    }

    public static void defineAirports(Airline_Trip_Emissions_Estimate__c nextATEE){
        airportCodes.add(String.valueOf(nextATEE.Origination_Airport__c));
        if (nextATEE.Layover_Airport__c != null){          
            airportCodes.add(String.valueOf(nextATEE.Layover_Airport__c));   
        }
        airportCodes.add(String.valueOf(nextATEE.Final_Destination_Airport__c));
        System.debug('airportCodes: ' + airportCodes);
    }


    public static void createWrapper(Airline_Trip_Emissions_Estimate__c nextATEE){
        CarbonBodyWrapper wrapper = new CarbonBodyWrapper();
        // Assign fields to newly initialized wrapper
        wrapper.type          = 'flight';
        wrapper.passengers    = nextATEE.Number_of_Passengers__c.intValue();
        wrapper.legs          = CarbonRequestSender.processLegs(airportCodes, nextATEE.Round_Trip__c);
        wrapper.distance_unit = 'mi';
 
        // Create displayLegs that will be passed to @future method
        displayLegs = CarbonRequestSender.displayLegs;

        // Need to serialize now since @future method will not accept wrapper class as parameter.
        // Instead. we will pass the JSON file as a String.
        wrapperJson = JSON.serialize(wrapper);

        // Create list of Strings to pass to @future method
        // To include (1) Id of nextATEE, (2) displayLegs, (3) wrapperJson
        List<String> requestParameters = new List<String>();
        requestParameters.add(nextATEE.Id);
        requestParameters.add(displayLegs);
        requestParameters.add(wrapperJson);

        sendRequest(requestParameters);
    }

    @future (callout=true)
    public static void sendRequest(List<String> requestParameters){ // Can only pass primitive type w/@future method
        // Parse the parameter List to get the information passed (now in new async transaction)
        idToPass    = requestParameters.get(0);
        displayLegs = requestParameters.get(1);
        String body = requestParameters.get(2);
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.carboninterface.com/api/v1/estimates');
        request.setHeader ('Authorization', 'Bearer ' + '3jeEa9IauqaGb0ZDTsxw');
        request.setMethod ('POST');
        request.setHeader ('Content-Type', 'application/json');
        request.setBody(body);
         
        // Create HTTP & HttpResponse objects and send the request
        Http httpCallout = new Http();
        HttpResponse response = httpCallout.send(request);
        
        // Pass response to processResponse method
        processResponse(response);
    }

    public static void processResponse(HttpResponse response){

        // Deserialize the response using the parse method of the CarbonResponseWrapper class
        CarbonResponseWrapper carbonBodyResponse = CarbonResponseWrapper.parse(response.getBody());
        
        // Process & print data to output console
        String dateRun      = carbonBodyResponse.data.attributes.estimated_at;
        String distanceUnit = carbonBodyResponse.data.attributes.distance_unit;

        System.debug('>>>>> Carbon Interface API - Flight Emission Estimates');
        System.debug('>>>>> Transaction Id: '       + carbonBodyResponse.data.id);
        System.debug('>>>>> Request Date/Time: '    + Datetime.valueOf(dateRun.replace('T',' ')).addHours(2).format());
        System.debug('>>>>> Number of Passengers: ' + carbonBodyResponse.data.attributes.passengers);
        System.debug('>>>>> Number of legs: '       + carbonBodyResponse.data.attributes.legs.size());
        System.debug('>>>>> Legs: '                 + displayLegs);
        System.debug('>>>>> Total distance (' + distanceUnit + '): ' + CarbonBodyResponse.data.attributes.distance_value);
        System.debug('>>>>> CO2e lb: ' + carbonBodyResponse.data.attributes.carbon_lb);
        System.debug('>>>>> CO2e kg: ' + carbonBodyResponse.data.attributes.carbon_kg);
        System.debug('>>>>> CO2e mt: ' + carbonBodyResponse.data.attributes.carbon_mt);
        
        System.debug('>>>>> idToPass: ' + idToPass);

        updateAtee(carbonBodyResponse);
    }

    public static void updateAtee(CarbonResponseWrapper carbonBodyResponse){
        // Use SOQL query to pull nextATEE record to update
        Airline_Trip_Emissions_Estimate__c atee = [SELECT Id
                                                     FROM Airline_Trip_Emissions_Estimate__c
                                                    WHERE Id = :idToPass];

        // Populate fields to update
        atee.Number_of_Legs__c    = carbonBodyResponse.data.attributes.legs.size();
        atee.Legs__c              = displayLegs;
        atee.Request_Date_Time__c = Datetime.valueOf(carbonBodyResponse.data.attributes.estimated_at.replace('T',' ')).addHours(2);
        atee.Transaction_ID__c    = carbonBodyResponse.data.id;
        atee.Flight_Distance__c   = carbonBodyResponse.data.attributes.distance_value;
        atee.Distance_Unit__c     = carbonBodyResponse.data.attributes.distance_unit;
        atee.CO2e_lb__c           = carbonBodyResponse.data.attributes.carbon_lb;
        atee.CO2e_kg__c           = carbonBodyResponse.data.attributes.carbon_kg;
        atee.CO2e_mt__c           = carbonBodyResponse.data.attributes.carbon_mt;

        Update atee; //I feel like I should have bulkified this async @future transaction -- right?
    }

}