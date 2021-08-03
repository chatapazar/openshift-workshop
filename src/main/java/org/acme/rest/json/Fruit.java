package org.acme.rest.json;

public class Fruit {

    public String name;
    public String description;

    public Fruit() {
    }

    public Fruit(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public String toString()
    {
        return "name: " + name + ", description: " + description;
    }
}