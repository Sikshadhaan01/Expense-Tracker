package com.example.FamilyExpenceTracker.Service;

import com.example.FamilyExpenceTracker.Entity.CategoryEntity;
import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    CategoryRepository categoryRepository;

    public String deleteById(String id) {
        categoryRepository.deleteById(Long.parseLong(id));
        return ("deleted");
    }
    public String insertCategory(CategoryEntity insert) {
        categoryRepository.save(insert);
        return ("User saved");

    }
    public List<CategoryEntity>findAll(){
        List<CategoryEntity>foundEntity=categoryRepository.findAll();
        return foundEntity;
    }
}
