public class CarbonWrapperClass {
        public String type;
        public Integer passengers;
        public List<Legs> legs;
        
        public class Legs {
            public String departure_airport;
            public String destination_airport;
        }
    }
}