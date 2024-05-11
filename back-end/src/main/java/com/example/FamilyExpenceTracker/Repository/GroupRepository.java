package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.GroupEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

public interface GroupRepository extends JpaRepository<GroupEntity, Long> {


    @Query(value = "select * from family where family_name=:fName", nativeQuery = true)
    List<GroupEntity> findUserByName(String fName);

    @Modifying
    @Transactional
    @Query(value = "delete from family where family_name=:fName", nativeQuery = true)
    int deleteByName(String fName);
    @Query(value = "select * from family where family_name=:fName and password=:pass", nativeQuery = true)
    GroupEntity login(String fName, String pass);

    @Query(value = "select * from family where user_id=:userId", nativeQuery = true)
    List<GroupEntity> getGroupsByUserId(Long userId);

    @Query(value = "select * from family where user_id=:userId and is_primary='Y'", nativeQuery = true)
    GroupEntity getPrimaryGroup(Long userId);
}
