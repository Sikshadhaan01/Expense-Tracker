package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity,Long> {
    @Query(value = "select * from user where user_name=:userName", nativeQuery = true)
    List<UserEntity> findUserByName(String userName);
    @Query(value = "select * from user where email=:email and password=:pass", nativeQuery = true)
    UserEntity login(String email, String pass);
}
