package com.example.FamilyExpenceTracker.Entity;

import jakarta.persistence.*;
@Entity
@Table(name = "group_members")
public class GroupMemberEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name="user_name")
    private  String userName;
    @Column(name="email")
    private  String email;
    @Column(name="group_id")
//    @JoinColumn(name="group_id", nullable=false)
    private  Long groupId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }
}
