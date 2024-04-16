package com.example.FamilyExpenceTracker.Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "family")
public class FamilyEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "family_name")
    private String fName;
    @Column(name = "family_budget")
    private String fBudget;
    @Column(name = "password")
    private String pass;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getfBudget() {
        return fBudget;
    }

    public void setfBudget(String fBudget) {
        this.fBudget = fBudget;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
}
