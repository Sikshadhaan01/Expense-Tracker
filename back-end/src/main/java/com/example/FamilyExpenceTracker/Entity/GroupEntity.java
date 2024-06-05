package com.example.FamilyExpenceTracker.Entity;

import javax.persistence.*;

import java.util.List;

@Entity
@Table(name = "family")
public class GroupEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "user_id")
    private Long userId;
    @Column(name = "group_name")
    private String groupName;
    @Column(name = "group_budget")
    private String groupBudget;
    @Column(name = "is_primary")
    private String isPrimary;
    @Column(name = "current_amount_in_percent")
    private String currentAmountInPercent;
    @Column(name = "current_amount")
    private String currentAmount;
//    @Transient
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "group_id")
    private List<GroupMemberEntity> members;

    public String getCurrentAmount() {
        return currentAmount;
    }

    public void setCurrentAmount(String currentAmount) {
        this.currentAmount = currentAmount;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getCurrentAmountInPercent() {
        return currentAmountInPercent;
    }

    public void setCurrentAmountInPercent(String currentAmountInPercent) {
        this.currentAmountInPercent = currentAmountInPercent;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupBudget() {
        return groupBudget;
    }

    public void setGroupBudget(String groupBudget) {
        this.groupBudget = groupBudget;
    }

    public String getIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(String isPrimary) {
        this.isPrimary = isPrimary;
    }

    public List<GroupMemberEntity> getMembers() {
        return members;
    }

    public void setMembers(List<GroupMemberEntity> members) {
        this.members = members;
    }
}
