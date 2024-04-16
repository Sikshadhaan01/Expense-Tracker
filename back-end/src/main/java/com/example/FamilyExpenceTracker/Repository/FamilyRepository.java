package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

public interface FamilyRepository extends JpaRepository<FamilyEntity, Long> {


    @Query(value = "select * from family where family_name=:fName", nativeQuery = true)
    List<FamilyEntity> findUserByName(String fName);

    @Modifying
    @Transactional
    @Query(value = "delete from family where family_name=:fName", nativeQuery = true)
    int deleteByName(String fName);
    @Query(value = "select * from family where family_name=:fName and password=:pass", nativeQuery = true)
    FamilyEntity login(String fName,String pass);

    }
