package com.example.FamilyExpenceTracker.Controller;

import com.example.FamilyExpenceTracker.Data.Response;
import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Service.FamilyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
@RestController
@RequestMapping(value="Family-Details")
public class FamilyController {
    @Autowired FamilyService familyService;

    @GetMapping(value = "find-user-by-name/{name}")
    public List<FamilyEntity> findUserByName(@PathVariable String name) {
        List<FamilyEntity> entities = familyService.findUserByName(name);
        return entities;
    }

    @GetMapping(value = "delete-by-name/{name}")
    public String deleteByName(@PathVariable String name) {
        String message = familyService.deleteByName(name);
        return message;
    }

    @PostMapping(value = "sign-up")
    public Response signUp(@RequestBody FamilyEntity insert) {
        String message = familyService.signUp(insert);
        if (message.equals("sign up successfully")) {
            Response response = new Response();
            response.setMessage(message);
            response.setStatusCode(200);
            response.setResult(new ArrayList<>());
            return response;
        } else {
            Response response = new Response();
            response.setMessage(message);
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }

    @PostMapping(value = "update-user")
    public String updateUser(@RequestBody FamilyEntity update) {
        String message = familyService.updateUser(update);
        return message;
    }

    @PostMapping(value = "login-user") 
    public Response LogIn(@RequestBody FamilyEntity login) {
        String message = familyService.LogIn(login);
        if (message.equals("Login Success")) {
            Response response = new Response();
            response.setMessage(message);
            response.setStatusCode(200);
            response.setResult(new ArrayList<>());
            return response;
        } else {
            Response response = new Response();
            response.setMessage(message);
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }
    @PostMapping(value = "insert-data")
    public String insertFamily(@RequestBody FamilyEntity insert) {
        String message = familyService.insertFamily(insert);
        return message;
    }
}