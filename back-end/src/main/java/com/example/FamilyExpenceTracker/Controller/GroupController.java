package com.example.FamilyExpenceTracker.Controller;

import com.example.FamilyExpenceTracker.Data.Response;
import com.example.FamilyExpenceTracker.Entity.GroupEntity;
import com.example.FamilyExpenceTracker.Service.GroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value="groups")
public class GroupController {
    @Autowired
    GroupService groupService;

    @PostMapping(value = "add-group")
    public Response insertGroup(@RequestBody GroupEntity insert) {
        GroupEntity group = groupService.insertGroup(insert);
        if (group != null) {
            Response response = new Response();
            response.setMessage("Group Created");
            response.setStatusCode(200);
            response.setResult(List.of(group));
            return response;
        } else {
            Response response = new Response();
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }

    @PostMapping(value = "get-groups-by-userid/{id}")
    public Response getGroupsByUserId(@PathVariable String id){
        List<GroupEntity> groups = groupService.getGroupsByUser(Long.parseLong(id));
        if (groups != null) {
            Response response = new Response();
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(groups);
            return response;
        } else {
            Response response = new Response();
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }

    @PostMapping(value = "set-as-primary/{groupId}/{userId}")
    public Response setAsPrimary(@PathVariable String groupId,@PathVariable String userId){
        GroupEntity group = groupService.setAsPrimary(groupId, userId);
        if (group != null) {
            Response response = new Response();
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(List.of(group));
            return response;
        } else {
            Response response = new Response();
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }

    @PostMapping(value = "get-primary-group/{userId}")
    public Response getPrimaryGroup(@PathVariable String userId){
        GroupEntity group = groupService.getPrimaryGroup(Long.parseLong(userId));
        if (group != null) {
            Response response = new Response();
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(List.of(group));
            return response;
        } else {
            Response response = new Response();
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }
}