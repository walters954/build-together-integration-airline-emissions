/* V4: Successfully populating sObject. */ 
public class CarbonInterfaceJsonDeserialize {
    
    public Data data;
    
    public class Data {
        public String id;
        public String type;
        public Attributes attributes;
    }

    public class Attributes {
        public Integer passengers;
        public List<Leg> legs;
        public String estimated_at;
        public Double carbon_g; //Initially this was integer, was not working.
        public Double carbon_lb; //Initially this was integer, was not working.
        public Double carbon_kg; //Initially this was integer, was not working.
        public Double carbon_mt; //Initially this was integer, was not working.
        public String distance_unit;
        public Double distance_value; //Initially this was decimal, was not working.
    }

    public class Leg {
        public String departure_airport;
        public String destination_airport;
    }
   
   public static CarbonFlightEstimate__c parse(String jsonResponse) {
        //Check if JSON Response is successfully passed in.       
        System.debug('JSON Response that is passed into this method: ' + jsonResponse); 

        //Deserialize.
        CarbonInterfaceJsonDeserialize deserializedResponse = (CarbonInterfaceJsonDeserialize)JSON.deserialize(jsonResponse, CarbonInterfaceJsonDeserialize.class);
       
        //Check if can pull out individual values for each JSON identifier. 
        System.debug('Deserialized date time: ' + deserializedResponse.data.attributes.estimated_at);
        System.debug('Deserialized carbon grams: ' + deserializedResponse.data.attributes.carbon_g);
        System.debug('Deserialized id: ' + deserializedResponse.data.id);


        CarbonFlightEstimate__c record = new CarbonFlightEstimate__c();
            record.carbon_g__c = deserializedResponse .data.attributes.carbon_g;
            record.carbon_lb__c = deserializedResponse .data.attributes.carbon_lb;
            record.carbon_kg__c = deserializedResponse .data.attributes.carbon_kg;
            record.carbon_mt__c = deserializedResponse .data.attributes.carbon_mt;
            record.distance_value__c = deserializedResponse .data.attributes.distance_value;        
        
        System.debug('New CarbonFlightEstimate Record populated with deserialized values: ' + record);
        return record;  
    }

/*
//V4.2 Attempting to populate sObject after deserialize method.
   public static CarbonInterfaceJsonDeserialize parse(String abc) {
        //Check if JSON Response is successfully passed in.       
        System.debug('JSON Response that is passed into this method: ' + abc); 

        //Deserialize.
        CarbonInterfaceJsonDeserialize deserializedResponse = (CarbonInterfaceJsonDeserialize)JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);
       
        //Pulling out individual values for each JSON identifier. 
        System.debug('Deserialized date time: ' + deserializedResponse.data.attributes.estimated_at);
        System.debug('Deserialized carbon grams: ' + deserializedResponse.data.attributes.carbon_g);
        System.debug('Deserialized id: ' + deserializedResponse.data.id);
       
        return (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);  
    }

    public static CarbonFlightEstimate__c populateRecord(CarbonInterfaceJsonDeserialize){
        CarbonInterfaceJsonDeserialize c = CarbonInterfaceJsonDeserialize.parse();

        CarbonFlightEstimate__c cfe = new CarbonFlightEstimate__c(
        carbon_g__c = c.data.attributes.carbon_g,
        carbon_lb__c = c.data.attributes.carbon_lb,
        carbon_kg__c = c.data.attributes.carbon_kg,
        carbon_mt__c = c.data.attributes.carbon_mt,
        distance_value__c = c.data.attributes.distance_value        
        );

        System.debug('New CarbonFlightEstimate Record populated with deserialized values: ' + cfe);
        return cfe; 
    }  
*/

/* 
//V4.1 Attempting to Populate sObject after deserialize method.
   public static CarbonInterfaceJsonDeserialize parse(String abc) {
        //Check if JSON Response is successfully passed in.       
        System.debug('JSON Response that is passed into this method: ' + abc); 

        //Deserialize.
        CarbonInterfaceJsonDeserialize deserializedResponse = (CarbonInterfaceJsonDeserialize)JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);
       
        //Pulling out individual values for each JSON identifier. 
        System.debug('Deserialized date time: ' + deserializedResponse.data.attributes.estimated_at);
        System.debug('Deserialized carbon grams: ' + deserializedResponse.data.attributes.carbon_g);
        System.debug('Deserialized id: ' + deserializedResponse.data.id);
       
        return (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);  
    }
    public static CarbonFlightEstimate__c populateRecord(){
        CarbonInterfaceJsonDeserialize c = CarbonInterfaceJsonDeserialize.parse();

		CarbonFlightEstimate__c cfe = new CarbonFlightEstimate__c;
        cfe.carbon_g__c = c.data.attributes.carbon_g;
        cfe.carbon_lb__c = c.data.attributes.carbon_lb;
        cfe.carbon_kg__c = c.attributes.carbon_kg;
        cfe.carbon_mt__c = c.data.attributes.carbon_mt;
        cfe.distance_value__c = c.data.attributes.distance_value;

        System.debug('New CarbonFlightEstimate Record populated with deserialized values: ' + c);
        return cfe; 
    }	
*/


// /* V3: Successful deserialize after many hours of troubleshooting -- issue was with integer/double/decimal. Now have to complete creating sObject. */ 
// public class CarbonInterfaceJsonDeserialize {
    
//     public Data data;
    
//     public class Data {
//         public String id;
//         public String type;
//         public Attributes attributes;
//     }

//     public class Attributes {
//         public Integer passengers;
//         public List<Leg> legs;
//         public String estimated_at;
//         public Double carbon_g; //Initially this was integer, was not working.
//         public Double carbon_lb; //Initially this was integer, was not working.
//         public Double carbon_kg; //Initially this was integer, was not working.
//         public Double carbon_mt; //Initially this was integer, was not working.
//         public String distance_unit;
//         public Double distance_value; //Initially this was decimal, was not working.
//     }

//     public class Leg {
//         public String departure_airport;
//         public String destination_airport;
//     }

// /*
//     public static CarbonInterfaceJsonDeserialize parse(String abc) {
//         System.debug('JSON Response that is passed into this method: ' + abc); 
//         return (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class); 
//     }
// */
    
// /*    
//      public static CarbonInterfaceJsonDeserialize parse(String abc) {
//          CarbonInterfaceJsonDeserialize c = (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);
//          return c;
//     }
// */  
   
//    public static CarbonInterfaceJsonDeserialize parse(String abc) {
//         //Check if JSON Response is successfully passed in.       
//         System.debug('JSON Response that is passed into this method: ' + abc); 

//         //Deserialize.
//         CarbonInterfaceJsonDeserialize deserializedResponse = (CarbonInterfaceJsonDeserialize)JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);
       
//         //Pulling out individual values for each JSON identifier. 
//         System.debug('Deserialized date time: ' + deserializedResponse.data.attributes.estimated_at);
//         System.debug('Deserialized carbon grams: ' + deserializedResponse.data.attributes.carbon_g);
//         System.debug('Deserialized id: ' + deserializedResponse.data.id);
       
//         return (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);  
//     }
// }



    /* V2: Tried this and the JSON response is being successfully passed. :D But returned deserialized values are null. D: Guessing it is having trouble deserializing because of the nested JSON objects. */
    // public with sharing class CarbonInterfaceJsonDeserialize {
    //     public class FlightEstResponse{
    //         String id;
    //         Datetime estimated_at;
    //         Integer carbon_g;
    //         Integer carbon_lb;
    //         Integer carbon_kg;
    //         Integer carbon_mt;
    //         Decimal distance_Value;
    //     }   
    //     public static FlightEstResponse parse(String abc) {  
    //         System.debug('JSON Response that is passed into the parse method: ' + abc);
    //         FlightEstResponse deserializedResponse = (FlightEstResponse)JSON.deserialize(abc, FlightEstResponse.class);
    
    //         System.debug('Deserialized date time: ' + deserializedResponse.estimated_at);
    //         System.debug('Deserialized carbon grams: ' + deserializedResponse.carbon_g);
    //         System.debug('Deserialized id: ' +deserializedResponse.id);
    //         return deserializedResponse;
    //     }
    // }

    /* V1: Tried this and could not get it to work. */   
    //  public class FlightEstResponse{
    //     String id;
    //     Datetime estimated_at;
    //     Integer carbon_g;
    //     Integer carbon_lb;
    //     Integer carbon_kg;
    //     Integer carbon_mt;
    //     Decimal distance_Value;
    //      
    //     public FlightEstResponse(){
    //         this.estimated_at = estimated_at;
    //         this.carbon_g = carbon_g;
    //         this.carbon_lb = carbon_lb;
    //         this.carbon_kg = carbon_kg;
    //         this.carbon_mt = carbon_mt;
    //         this.distance_Value = distance_Value;
    //     }
    // }
    
    // How to feed the JSON deserialize above into this method...??
    // public CarbonEmission__c updateCarbonEmissionData(){
    //     CarbonEmission__c ce = new CarbonEmission__c();
    //     ce.estimated_at = deserializedResponse.estimated_at;
    //     ce.carbon_g = deserializedResponse.carbon_g;
    //     ce.carbon_lb = deserializedResponse.carbon_lb;
    //     ce.carbon_kg = deserializedResponse.carbon_kg;
    //     ce.carbon_mt = deserializedResponse.carbon_mt;
    //     ce.distance_Value = deserializedResponse.distance_Value;

    //     return ce;
    // }

