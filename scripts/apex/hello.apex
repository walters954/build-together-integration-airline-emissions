CarbonCallout.callout();
// CarbonCallout.callout();

Map<String,Object> data = new Map<String,Object>();
data.put('type','flight');
data.put('passengers',2);
data.put('distance_unit','mi');
Map<String,Object> leg2 = new Map<String,Object>();
leg2.put('departure_airport', 'OSL');
leg2.put('destination_airport', 'VIE');
Map<String,Object> leg1 = new Map<String,Object>();
leg1.put('departure_airport', 'VIE');
leg1.put('destination_airport', 'OSL');
data.put('legs', new List<Object>{leg1,leg2});
System.debug(JSON.serialize(data));

//[{"departure_airport": "VIE", "destination_airport": "OSL"},{"departure_airport": "OSL", "destination_airport": "VIE"}]
//{"type": "flight","passengers": 2,"legs": [{"departure_airport": "VIE", "destination_airport": "OSL"},{"departure_airport": "OSL", "destination_airport": "VIE"}],"distance_unit": "mi"}

