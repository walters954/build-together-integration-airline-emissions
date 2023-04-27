/* V3: Not working yet... */
// public with sharing class CarbonInterfaceJsonDeserialize {
    
//     public class Data {
//         String id;
//         String type;
//         Attributes attributes;
//     }

//     public class Attributes {
//         Integer passengers;
//         String estimated_at;
//         Integer carbon_g;
//         Integer carbon_lb;
//         Integer carbon_kg;
//         Integer carbon_mt;
//         String distance_unit;
//         Double distance_value;
//     }
    
//     public static CarbonInterfaceJsonDeserialize parse(String abc) {
//         return (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);
//    }

//    public static CarbonInterfaceJsonDeserialize parse(String abc) {
//         CarbonInterfaceJsonDeserialize deserializedResponse = (CarbonInterfaceJsonDeserialize)JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);
        
//         System.debug('Deserialized date time: ' + deserializedResponse.data.attributes.estimated_at);
//         System.debug('Deserialized carbon grams: ' + deserializedResponse.data.attributes.carbon_g);
//         System.debug('Deserialized id: ' + deserializedResponse.data.id);
        
//         return (CarbonInterfaceJsonDeserialize) System.JSON.deserialize(abc, CarbonInterfaceJsonDeserialize.class);  
//     }    
// }


    /* V2: Tried this and the JSON response is being successfully passed. :D But returned deserialized values are null. D: Guessing it is having trouble deserializing becuase of the nested JSON objects. */
    public with sharing class CarbonInterfaceJsonDeserialize {
        public class FlightEstResponse{
            String id;
            Datetime estimated_at;
            Integer carbon_g;
            Integer carbon_lb;
            Integer carbon_kg;
            Integer carbon_mt;
            Decimal distance_Value;
        }   
        public static FlightEstResponse parse(String abc) {  
            System.debug('JSON Response that is passed into the parse method: ' + abc);
            FlightEstResponse deserializedResponse = (FlightEstResponse)JSON.deserialize(abc, FlightEstResponse.class);
    
            System.debug('Deserialized date time: ' + deserializedResponse.estimated_at);
            System.debug('Deserialized carbon grams: ' + deserializedResponse.carbon_g);
            System.debug('Deserialized id: ' +deserializedResponse.id);
            return deserializedResponse;
        }
    }

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

