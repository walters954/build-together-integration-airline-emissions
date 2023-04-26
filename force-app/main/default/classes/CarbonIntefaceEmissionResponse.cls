public with sharing class CarbonIntefaceEmissionResponse {

    @AuraEnabled public String id;
	@AuraEnabled public String type;
//	@AuraEnabled public Attributes attributes;

    public CarbonIntefaceEmissionResponse( String responseBody) {

     /*  this = JSON.deserialize(responseBody, CarbonIntefaceEmissionResponse.class); */

    }
}