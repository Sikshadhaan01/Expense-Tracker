package com.example.FamilyExpenceTracker.Entity;

import javax.persistence.*;
import org.springframework.core.SpringVersion;

@Entity
@Table(name = "category")
public class
CategoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name="category_name")
    private String categoryName;
    @Column(name="category_icon")
    private  String categoryIcon;
    @Column(name = "category_color")
    private String categoryColor;

    public String getCategoryColor() {
        return categoryColor;
    }

    public void setCategoryColor(String categoryColor) {
        this.categoryColor = categoryColor;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryIcon() {
        return categoryIcon;
    }

    public void setCategoryIcon(String categoryIcon) {
        this.categoryIcon = categoryIcon;
    }
}
