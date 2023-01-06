package com.example.springboot.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Retern {
    // data from book
    private String isbn; // primary key 2
    private String name; // book's name
    // data from user
    private String email; // primary key 1
    private String uid;
    private String username;
    private String phone;
    // own data
    private Integer id;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime cDate;
    private String bStatus; // borrow_status
    private Integer duration; // days of the borrow
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rDate; // the actual return date
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime aDate; // the actual return date
}
