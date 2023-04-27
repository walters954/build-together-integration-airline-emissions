public class Passenger {
    public String name {get; set;}
    public Integer age {get; set;}
    public String gender {get; set;}
    public Decimal weight {get; set;}
    
    public Passenger(String name, Integer age, String gender) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.weight = weight;
    }
}
