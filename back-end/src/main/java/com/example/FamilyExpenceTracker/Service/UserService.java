package com.example.FamilyExpenceTracker.Service;

import com.example.FamilyExpenceTracker.Entity.UserEntity;
import com.example.FamilyExpenceTracker.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;
    public String signUp(UserEntity insert) {
        List<UserEntity> existingUser = userRepository.findUserByName(insert.getUserName());
        if (existingUser.isEmpty()) {
            userRepository.save(insert);
            return ("sign up successfully");
        } else {
            return ("Name id already exist");
        }
    }
    public UserEntity LogIn(UserEntity login) {
        UserEntity foundUser =userRepository.login(login.getEmail(), login.getPass());
        if (foundUser != null) {
            return foundUser;

        } else {
            return null;
        }
    }

    public List<UserEntity> getAll() {
        return userRepository.findAll();
    }
}
