package com.example.FamilyExpenceTracker.Controller;

import com.example.FamilyExpenceTracker.Data.Response;
import com.example.FamilyExpenceTracker.Entity.MemberEntity;
import com.example.FamilyExpenceTracker.Service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.AuthProvider;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(value="Member-Details")
public class MemberController {
    @Autowired MemberService memberService;

    @GetMapping(value = "find-user-by-name/{name}")
    public List<MemberEntity> findUserByName(@PathVariable String name) {
        List<MemberEntity> entities = memberService.findUserByName(name);
        return entities;
    }

    @GetMapping(value = "delete-by-name/{name}")
    public String deleteByName(@PathVariable String name) {
        String message = memberService.deleteByName(name);
        return message;
    }

    @PostMapping(value = "insert-data")
    public String insertMember(@RequestBody MemberEntity insert) {
        String message = memberService.insertMember(insert);
        return message;
    }
    @PostMapping(value="update-member")
    public String updateMember(@RequestBody MemberEntity update) {
        System.out.println("MNam "+update.getMemberName());
        String message=memberService.updateMember(update);
        return message;
    }


    }
