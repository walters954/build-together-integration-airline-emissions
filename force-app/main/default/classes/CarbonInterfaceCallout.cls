public class CarbonInterfaceCallout {

    public String type;
    public Integer passengers;
    public List<Legs> legs;
    public String distance_unit;
    public String departure_airport;
    public String destination_airport;

    Public class Legs{
    public String departure_airport;
    public String destination_airport;
    }
    
    

    
    //Constructor 
    public CarbonInterfaceCallout(String type, Integer passengers, String departure_airport, String destination_airport, String distance_unit, List<Legs> legs){
     
    
    this.type = type;
    this.passengers= passengers;
    this.legs = legs;
    this.departure_airport =  departure_airport;
    this.destination_airport =  destination_airport;
    this.distance_unit = distance_unit;
    Legs legA = new Legs();
    legA.departure_airport= departure_airport;
    legA.destination_airport = destination_airport;
    legs.add(legA);

    Legs legB = new Legs();
    legB.departure_airport= destination_airport;
    legB.destination_airport = departure_airport;
    legs.add(legB);

    //Create an Instance of the Wrapper Class
    CarbonInterfaceRequestWrapper wrapper = new CarbonInterfaceRequestWrapper();
    List<CarbonInterfaceRequestWrapper.Legs> legsList = new List<CarbonInterfaceRequestWrapper.Legs>();
    CarbonInterfaceRequestWrapper.Legs leg1 = new CarbonInterfaceRequestWrapper.Legs();
    leg1.departure_airport = departure_airport;
    leg1.destination_airport = destination_airport;
    legsList.add(leg1);

    CarbonInterfaceRequestWrapper.Legs leg2 = new CarbonInterfaceRequestWrapper.Legs();
    leg2.departure_airport = destination_airport;
    leg2.destination_airport= departure_airport;
    legsList.add(leg2);

    wrapper.type= type;
    wrapper.passengers= passengers;
    wrapper.distance_unit= distance_unit;
    wrapper.legs = legsList ;

    
    
    /*Create a Leg1 sObject
    CarbonInterfaceRequestWrapper.Leg leg1 = new CarbonInterfaceRequestWrapper.Leg();
    leg1.departure_airport = this.departure_airport ;
    leg1.destination_airport= this.destination_airport ;
    wrapper.legs.add(leg1);

    //Create a Leg2 sObject
    CarbonInterfaceRequestWrapper.Leg leg2 = new CarbonInterfaceRequestWrapper.Leg();
    this.departure_airport   = leg2.destination_airport;
    this.destination_airport = leg2.departure_airport;
    wrapper.legs.add(leg2);*/

    sendRequest(wrapper);// Call the sendRequest method passing the wrapper object

      }
    
    
    public static void sendRequest (CarbonInterfaceRequestWrapper wrapper){
       
        //Prepare Http Request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Carbon_Interface_Callout');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setMethod('POST');
        String reqBody = JSON.serialize(wrapper);
        req.setBody(reqBody);
        

        //Create Http Object
        Http http = new Http();

        // Response object
        HttpResponse response = http.send(req);
        system.debug(response);
        system.debug(response.getBody());
        getResponse(response); //  Passing the response in the getResponse method
            
    
        }   
                            
               
        //Get Response in Salesforce 
        public static void getResponse(HttpResponse response){
            //if the request is successful parse the JSON response

            if(response.getStatusCode()==200){
         //Deserialiazing the JSon Response
        
        
        
         
       
     }



        }

}