package com.example.FamilyExpenceTracker.Controller;

import com.example.FamilyExpenceTracker.Entity.CategoryEntity;
import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value="category")
public class CategoryController {
    @Autowired CategoryService categoryService;

    @GetMapping(value = "delete-by-id/{id}")
    public String deleteById(@PathVariable String id) {
        String message = categoryService.deleteById(id);
        return message;
    }
    @PostMapping(value = "insert")
    public String insertCategory(@RequestBody CategoryEntity insert) {
        String message = categoryService.insertCategory(insert);
        return message;
    }
    @GetMapping(value = "find-all")
    public List<CategoryEntity> findAll() {
        List<CategoryEntity> foundEntity = categoryService.findAll();
        return foundEntity;

    }

}
