/*Map<String,Object> data = new Map<String,Object>();
data.put('type','flight');
data.put('passengers',2);
data.put('distance_unit','mi');
Map<String,Object> leg1 = new Map<String,Object>();
leg1.put('departure_airport', 'VIE');
leg1.put('destination_airport', 'OSL');
Map<String,Object> leg2 = new Map<String,Object>();
leg2.put('departure_airport', 'OSL');
leg2.put('destination_airport', 'VIE');
CarbonCallout.getFlightEstimateRequest(data);*/


System.debug('Result from: ' + CarbonCallout.getFlightEstimateRequest());