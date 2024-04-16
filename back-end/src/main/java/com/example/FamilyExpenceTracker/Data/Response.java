package com.example.FamilyExpenceTracker.Data;

import java.util.List;

public class Response {
private String message;
private Long statuscode;
private List result;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Long getStatuscode() {
        return statuscode;
    }

    public void setStatuscode(Long statuscode) {
        this.statuscode = statuscode;
    }

    public List getResult() {
        return result;
    }

    public void setResult(List result) {
        this.result = result;
    }

    public void setStatusCode(int i) {
        this.statuscode=statuscode;
    }
}

