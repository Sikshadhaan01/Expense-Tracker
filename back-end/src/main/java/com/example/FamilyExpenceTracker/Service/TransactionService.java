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
        System.out.println("Group ID "+insert.getGroupId());
        GroupEntity primaryGroup = groupRepository.findById(insert.getGroupId()).get();
        if(insert.getTransactionType().equals("Expense")){
            if(Double.parseDouble(insert.getAmount()) > Double.parseDouble(primaryGroup.getCurrentAmount())){
                return  null;
            }
            double currentAmount = Double.parseDouble(primaryGroup.getCurrentAmount())-Double.parseDouble(insert.getAmount());
            primaryGroup.setCurrentAmount(String.valueOf(currentAmount));
//            double numerator = Double.parseDouble(primaryGroup.getCurrentAmount());
            double totalAmount = Double.parseDouble(primaryGroup.getGroupBudget());

            // Calculate the percentage
            double percentage = this.calculatePercentage(currentAmount,totalAmount);
            primaryGroup.setCurrentAmountInPercent(String.valueOf(percentage));
        }else{
            double currentBudget = Double.parseDouble(primaryGroup.getGroupBudget())+Double.parseDouble(insert.getAmount());
            primaryGroup.setGroupBudget(String.valueOf(currentBudget));
            Double currentAmount = Double.parseDouble(primaryGroup.getCurrentAmount())+Double.parseDouble(insert.getAmount());
            primaryGroup.setCurrentAmount(String.valueOf(currentAmount));
            double totalAmount = Double.parseDouble(primaryGroup.getGroupBudget());
            // Calculate the percentage
//            double percentage = this.calculatePercentage(currentAmount,totalAmount);
            double percentage = BigDecimal.valueOf((currentAmount / totalAmount) * 100)
                    .setScale(1, RoundingMode.HALF_DOWN)
                    .doubleValue();
            primaryGroup.setCurrentAmountInPercent(String.valueOf(percentage));
        }
        groupRepository.save(primaryGroup);
        return  transactionRepository.save(insert);

    }
    public double calculatePercentage(double currentAmount, double totalAmount) {
        if (totalAmount == 0) {
            return 0; // or handle the case where totalAmount is 0 to avoid division by zero
        }
        double percentage = (currentAmount / totalAmount) * 100;
        System.out.println("PERCENTAGE "+percentage);
        return percentage;
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

