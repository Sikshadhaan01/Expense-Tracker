package com.example.FamilyExpenceTracker.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.FamilyExpenceTracker.Entity.GroupEntity;
import com.example.FamilyExpenceTracker.Repository.GroupRepository;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class GroupService {
    @Autowired
    GroupRepository groupRepository;

    public GroupEntity insertGroup(GroupEntity entity) {
        List<GroupEntity> groups = groupRepository.getGroupsByUserId(entity.getUserId());
        System.out.println("Groups "+groups);
        if(groups.isEmpty()){
            entity.setIsPrimary("Y");
            System.out.println("Entity "+entity.getIsPrimary());
        }
        if(entity.getIsPrimary().equals("Y")){
            if(!groups.isEmpty()){
                List<GroupEntity> primaryGroup = groups.stream()
                        .filter((e) -> e.getIsPrimary().equals("Y"))
                        .toList();
                primaryGroup.get(0).setIsPrimary("N");
                groupRepository.save(primaryGroup.get(0));
            }
        }
        double numerator = Double.parseDouble(entity.getCurrentAmount());
        double denominator = Double.parseDouble(entity.getGroupBudget());
        // Calculate the percentage
        double percentage = BigDecimal.valueOf((numerator / denominator) * 100)
                .setScale(3, RoundingMode.HALF_UP)
                .doubleValue();
        System.out.println("PERCENTAGE "+percentage);
        entity.setCurrentAmountInPercent(String.valueOf(percentage));
        GroupEntity savedEntity = groupRepository.save(entity);
        return  savedEntity;
    }

    public List<GroupEntity> getGroupsByUser(Long userId) {

        return groupRepository.getGroupsByUserId(userId);
    }

    public GroupEntity getPrimaryGroup(Long userId) {
        return groupRepository.getPrimaryGroup(userId);
    }

    public GroupEntity setAsPrimary(String groupId, String userId) {
        List<GroupEntity> groups = groupRepository.getGroupsByUserId(Long.parseLong(userId));
        System.out.println("groups :"+groups);
        if(!groups.isEmpty()){
            List<GroupEntity> primaryGroup = groups.stream()
                    .filter((e) -> e.getIsPrimary().equals("Y"))
                    .toList();
            if(!primaryGroup.isEmpty()){
                primaryGroup.get(0).setIsPrimary("N");
                groupRepository.save(primaryGroup.get(0));
            }
        }
        Optional<GroupEntity> savedEntity = groupRepository.findById(Long.parseLong(groupId));
        savedEntity.get().setIsPrimary("Y");
        groupRepository.save(savedEntity.get());
//        return groupRepository.getPrimaryGroup(userId);
        return savedEntity.get();
    }
}
