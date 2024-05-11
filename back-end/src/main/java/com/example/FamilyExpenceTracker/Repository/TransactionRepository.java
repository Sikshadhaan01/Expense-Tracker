package com.example.FamilyExpenceTracker.Repository;

import com.example.FamilyExpenceTracker.Entity.MemberEntity;
import com.example.FamilyExpenceTracker.Entity.TransactionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface TransactionRepository extends JpaRepository<TransactionEntity,Long> {
    @Query(value = "select * from transaction where user_id=:id and month=:month and year=:year and transaction_type like %:transactionType", nativeQuery = true)
    List<TransactionEntity> findTransactionByUser(String id, String month, String year, String transactionType);

    @Modifying
    @Transactional
    @Query(value = "delete from transaction where transaction_name=:name", nativeQuery = true)
    int deleteByName(String name);
}
