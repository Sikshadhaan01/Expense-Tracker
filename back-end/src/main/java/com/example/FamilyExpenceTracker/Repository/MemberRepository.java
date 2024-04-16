package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Entity.MemberEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface MemberRepository extends JpaRepository<MemberEntity,Long> {
    @Query(value = "select * from member where member_name=:mName", nativeQuery = true)
    List<MemberEntity> findUserByName(String mName);

    @Modifying
    @Transactional
    @Query(value = "delete from member where member_name=:mName", nativeQuery = true)
    int deleteByName(String mName);
}
