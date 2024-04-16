package com.example.FamilyExpenceTracker.Controller;

import com.example.FamilyExpenceTracker.Data.Response;
import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Entity.UserEntity;
import com.example.FamilyExpenceTracker.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@CrossOrigin
@RequestMapping(value = "users")
public class UserController {
    @Autowired UserService userService;
    @PostMapping(value = "sign-up")
    public Response signUp(@RequestBody UserEntity insert) {
        String message = userService.signUp(insert);
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
    @PostMapping(value = "login-user")
    public Response LogIn(@RequestBody UserEntity login) {
        String message = userService.LogIn(login);
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
}
