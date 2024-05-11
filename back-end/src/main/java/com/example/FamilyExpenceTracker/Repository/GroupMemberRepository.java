package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.GroupMemberEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GroupMemberRepository extends JpaRepository<GroupMemberEntity,Long> {
}
