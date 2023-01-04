package com.example.springboot.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class Borrow {
    // data from book
    private String isbn; // primary key 2
    private String name; // book's name
    private Integer credit;
    // data from user
    private String email; // primary key 1
    private String username;
    private String phone;
    // own data
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date cDate;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date uDate;

}
