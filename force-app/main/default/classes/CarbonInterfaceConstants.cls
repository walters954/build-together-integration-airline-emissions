public class CarbonInterfaceConstants {
    public static final String API_BASE_URL = 'https://api.carboninterface.com/v1';
    public static String API_KEY {
        get {
            return API_Key__c.getValues('API_key').API_Key__c;
        }
    }
    public static final String API_TOKEN_HEADER = 'Authorization';
    public static final String API_TOKEN_PREFIX = 'Bearer';
    public static final String FLIGHT_ESTIMATE_OBJECT_API_NAME = 'Flight_Estimate__c';
}
