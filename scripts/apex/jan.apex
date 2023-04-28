CarbonInterfaceRequestWrapper wrapper = new CarbonInterfaceRequestWrapper();
wrapper.type= 'flight';
wrapper.passengers= 2;
wrapper.distance_unit='mi';
CarbonInterfaceRequestWrapper.Leg leg1 = new CarbonInterfaceRequestWrapper.Leg();
leg1.departure_airport = 'sfo';
leg1.destination_airport = 'yyz';
CarbonInterfaceRequestWrapper.Leg leg2 = new CarbonInterfaceRequestWrapper.Leg();
leg2.departure_airport = 'yyz';
leg2.destination_airport = 'sfo';
wrapper.legs = new List<CarbonInterfaceRequestWrapper.Leg>{leg1, leg2};

CarbonInterfaceCallout.sendRequest(wrapper);
