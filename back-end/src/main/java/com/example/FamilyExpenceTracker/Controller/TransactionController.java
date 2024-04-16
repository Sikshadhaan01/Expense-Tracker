package com.example.FamilyExpenceTracker.Controller;


import com.example.FamilyExpenceTracker.Data.Response;
import com.example.FamilyExpenceTracker.Entity.MemberEntity;
import com.example.FamilyExpenceTracker.Entity.TransactionEntity;
import com.example.FamilyExpenceTracker.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(value = "transaction")
public class TransactionController {
    @Autowired
    TransactionService transactionService;
    @GetMapping(value = "find-user-by-name/{name}")
    public List<TransactionEntity> findUserByName(@PathVariable String name) {
        List<TransactionEntity> entities = transactionService.findUserByName(name);
        return entities;
    }
    @GetMapping(value = "delete-by-name/{name}")
    public String deleteByName(@PathVariable String name) {
        String message = transactionService.deleteByName(name);
        return message;
    }
    @PostMapping(value = "insert-trans")
    public String insertTransaction(@RequestBody TransactionEntity insert) {
        String message = transactionService.insertTransaction(insert);
            return message;
    }
    @PostMapping(value = "update-trans")
    public String updateTrans(@RequestBody TransactionEntity update)
    {
        String message = transactionService.updateTrans(update);
        return message;
    }

   }
