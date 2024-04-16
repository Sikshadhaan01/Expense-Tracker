package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.CategoryEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CategoryRepository extends JpaRepository<CategoryEntity,Long> {
    @Query(value = "select * from category where category_name=:categoryName", nativeQuery = true)
    List<CategoryEntity> findUserByName(String categoryName);
    @Modifying
    @Transactional
    @Query(value = "delete from category where category_name=:categoryName", nativeQuery = true)
    int deleteByName(String categoryName);

}
