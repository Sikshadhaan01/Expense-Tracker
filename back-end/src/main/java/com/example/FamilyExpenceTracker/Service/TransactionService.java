package com.example.FamilyExpenceTracker.Service;

import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Entity.MemberEntity;
import com.example.FamilyExpenceTracker.Entity.TransactionEntity;
import com.example.FamilyExpenceTracker.Repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {
    @Autowired
    TransactionRepository transactionRepository;

    public List<TransactionEntity> findUserByName(String name) {

        List<TransactionEntity> foundEntities = transactionRepository.findUserByName(name);
        return foundEntities;

    }

    public String deleteByName(String name) {
        transactionRepository.deleteByName(name);
        return ("deleted");
    }

    public String insertTransaction(TransactionEntity insert) {
        transactionRepository.save(insert);
        return ("User saved");

    }

    public String updateTrans(TransactionEntity update) {
        Optional<TransactionEntity> existingUser = transactionRepository.findById(update.getId());
        if (existingUser.isPresent()) {
            existingUser.get().settName(update.gettName());
            existingUser.get().setMoney(update.getMoney());
            existingUser.get().setDay(update.getDay());
            transactionRepository.save(existingUser.get());
            return ("user updated");
        } else {
            return ("transaction not found");
        }
    }
}

