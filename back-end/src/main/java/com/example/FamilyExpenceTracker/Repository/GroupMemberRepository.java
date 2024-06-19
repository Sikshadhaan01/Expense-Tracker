package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.GroupEntity;
import com.example.FamilyExpenceTracker.Entity.GroupMemberEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface GroupMemberRepository extends JpaRepository<GroupMemberEntity,Long> {
    @Query(value = "select * from group_members where email=:email", nativeQuery = true)
    List<GroupMemberEntity> findMemberByEmail(String email);
}
