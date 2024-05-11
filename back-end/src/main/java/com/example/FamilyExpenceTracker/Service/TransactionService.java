package com.example.FamilyExpenceTracker.Service;

import com.example.FamilyExpenceTracker.Data.FilterTransactionModal;
import com.example.FamilyExpenceTracker.Entity.GroupEntity;
import com.example.FamilyExpenceTracker.Entity.TransactionEntity;
import com.example.FamilyExpenceTracker.Repository.GroupRepository;
import com.example.FamilyExpenceTracker.Repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {
    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    GroupRepository groupRepository;

//    public List<TransactionEntity> findUserByName(String name) {
//        List<TransactionEntity> foundEntities = transactionRepository.findTransactionByUser(name);
//        return foundEntities;
//
//    }

    public String deleteByName(String name) {
        transactionRepository.deleteByName(name);
        return ("deleted");
    }

    public TransactionEntity insertTransaction(TransactionEntity insert) {
        GroupEntity primaryGroup = groupRepository.getPrimaryGroup(Long.parseLong(insert.getUserId()));
        Long currentAmount = Long.parseLong(primaryGroup.getCurrentAmount())-Long.parseLong(insert.getAmount());
        primaryGroup.setCurrentAmount(currentAmount.toString());
        double numerator = Double.parseDouble(primaryGroup.getCurrentAmount());
        double denominator = Double.parseDouble(primaryGroup.getGroupBudget());
        // Calculate the percentage
        double percentage = BigDecimal.valueOf((numerator / denominator) * 100)
                .setScale(1, RoundingMode.HALF_UP)
                .doubleValue();
        primaryGroup.setCurrentAmountInPercent(String.valueOf(percentage));
        groupRepository.save(primaryGroup);
        return  transactionRepository.save(insert);

    }

    public List<TransactionEntity> getUserTransactions(FilterTransactionModal modal) {
        return transactionRepository.findTransactionByUser(modal.getUserId(),
                modal.getMonth(), modal.getYear(), modal.getTransType());
    }

    public String updateTrans(TransactionEntity update) {
        Optional<TransactionEntity> existingUser = transactionRepository.findById(update.getId());
        if (existingUser.isPresent()) {
//            existingUser.get().settName(update.gettName());
//            existingUser.get().setMoney(update.getMoney());
//            existingUser.get().setDay(update.getDay());
//            transactionRepository.save(existingUser.get());
            return ("user updated");
        } else {
            return ("transaction not found");
        }
    }
}

