package com.smartHire.model;

public class Skill {

    private Long id;
    private String name;

    // Default Constructor
    public Skill() {
    }

    // Constructor for creating a new skill
    public Skill(String name) {
        this.name = name;
    }

    // Full Constructor
    public Skill(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Skill [id=" + id + ", name=" + name + "]";
    }
}