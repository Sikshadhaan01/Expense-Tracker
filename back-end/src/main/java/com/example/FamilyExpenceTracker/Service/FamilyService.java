package com.example.FamilyExpenceTracker.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Repository.FamilyRepository;


import java.util.List;

import static org.springframework.data.jpa.domain.AbstractPersistable_.id;

@Service
public class FamilyService {
    @Autowired FamilyRepository familyRepository;

    public List<FamilyEntity> findUserByName(String name) {

            List<FamilyEntity> foundEntities = familyRepository.findUserByName(name);
            return foundEntities;

    }
    public String deleteByName(String name) {
        familyRepository.deleteByName(name);
        return ("deleted");
    }
    public String signUp(FamilyEntity insert) {
        List<FamilyEntity> existingUser = familyRepository.findUserByName(insert.getfName());
        if (existingUser.isEmpty()) {
            familyRepository.save(insert);
            return ("sign up successfully");
        } else {
            return ("Name id already exist");
        }
    }
        public String LogIn(FamilyEntity login) {
            FamilyEntity foundUser =familyRepository.login(login.getfName(), login.getPass());
            if (foundUser != null) {
                return ("Login Success");

            } else {
                return ("Login Failed");
            }
        }
    public String updateUser(FamilyEntity update) {
        FamilyEntity existingUser = familyRepository.findById(update.getId()).get();
        existingUser.setfName(update.getfName());
        existingUser.setfBudget(update.getfBudget());
        existingUser.setPass(update.getPass());
        familyRepository.save(existingUser);
        return("user updated");
    }
    public String insertFamily(FamilyEntity insert) {
        familyRepository.save(insert);
        return ("User saved");

    }
}
