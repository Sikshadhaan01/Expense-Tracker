package com.example.FamilyExpenceTracker.Controller;


import com.example.FamilyExpenceTracker.Data.FilterTransactionModal;
import com.example.FamilyExpenceTracker.Data.Response;
import com.example.FamilyExpenceTracker.Entity.TransactionEntity;
import com.example.FamilyExpenceTracker.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value = "transaction")
public class TransactionController {
    @Autowired
    TransactionService transactionService;

//    @GetMapping(value = "find-user-by-name/{name}")
//    public List<TransactionEntity> findUserByName(@PathVariable String name) {
//        List<TransactionEntity> entities = transactionService.findUserByName(name);
//        return entities;
//    }

    @GetMapping(value = "delete-by-name/{name}")
    public String deleteByName(@PathVariable String name) {
        String message = transactionService.deleteByName(name);
        return message;
    }

    @PostMapping(value = "insert-trans")
    public Response insertTransaction(@RequestBody TransactionEntity insert) {
        TransactionEntity entity = transactionService.insertTransaction(insert);
        if (entity != null) {
            Response response = new Response();
            response.setMessage("Group Created");
            response.setStatusCode(200);
            response.setResult(List.of(entity));
            return response;
        } else {
            Response response = new Response();
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }

    @PostMapping(value = "update-trans")
    public String updateTrans(@RequestBody TransactionEntity update) {
        String message = transactionService.updateTrans(update);
        return message;
    }

    @PostMapping(value = "get-user-transactions")
    public Response getTransactionByUserId(@RequestBody FilterTransactionModal modal) {
        List<TransactionEntity> entities = transactionService.getUserTransactions(modal);
        Response response = new Response();
        response.setMessage("Success");
        response.setStatusCode(200);
        response.setResult(entities);
        return response;
    }

}
