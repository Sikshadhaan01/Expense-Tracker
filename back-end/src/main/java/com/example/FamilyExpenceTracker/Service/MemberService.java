package com.example.FamilyExpenceTracker.Service;

import com.example.FamilyExpenceTracker.Entity.FamilyEntity;
import com.example.FamilyExpenceTracker.Entity.MemberEntity;
import com.example.FamilyExpenceTracker.Repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;
    public List<MemberEntity> findUserByName(String name) {

        List<MemberEntity> foundEntities = memberRepository.findUserByName(name);
        return foundEntities;

    }
    public String deleteByName(String name) {
        memberRepository.deleteByName(name);
        return ("deleted");
    }
    public String insertMember(MemberEntity insert) {
        memberRepository.save(insert);
        return ("User saved");

    }
    public String updateMember(MemberEntity update)
    {
        Optional<MemberEntity> existingUser=memberRepository.findById(update.getId());
        if(existingUser.isPresent()){
//            System.out.println("MNam "+update.getMname());
            existingUser.get().setMemberName(update.getMemberName());
            existingUser.get().setIncome(update.getIncome());
            existingUser.get().setOccupation(update.getOccupation());
            existingUser.get().setMobNo(update.getMobNo());
            existingUser.get().setMemRole(update.getMemRole());
            existingUser.get().setfId(update.getfId());
            memberRepository.save(existingUser.get());
            return ("user updated");
        }else{
            return ("user not found");
        }

    }

}
