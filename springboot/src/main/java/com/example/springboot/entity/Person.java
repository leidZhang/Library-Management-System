package com.example.springboot.entity;

import lombok.Data;

@Data
public class Person {
    private String email;
    private String fname;
    private String minit;
    private String lname;
    private String username;
    private String province;
    private String city;
    private String street;
    private String phone;
    private boolean status;
}
