package model;


public class Property {
    private int id;
    private String location;
    private double price;
    private boolean stare;
    private PropertyType type;

    public Property(int id,String location,double price,boolean stare,PropertyType type) {
        this.id = id;
        this.stare=stare;
        this.location=location;
        this.price=price;
        this.type=type;
    }

    public enum PropertyType {
    APARTMENT,
    HOUSE
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean getStare() {
        return stare;
    }

    public void setStare(boolean stare) {
        this.stare = stare;
    }

    public PropertyType getType() {
        return type;
    }

    public void setType(PropertyType type) {
        this.type = type;
    }
}