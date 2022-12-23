package com.example.springboot.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class User extends Person {
    private String gender;
    private String uid;
    private Integer age;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date cTime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date uTime;
}
