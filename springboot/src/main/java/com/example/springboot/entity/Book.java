package com.example.springboot.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class Book {
    private String isbn; // primary key
    private String name;
    private String description;
    private String category;
    private String publish_date;
    private String author;
    private String publisher;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date cDate;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date uDate;
    private String cover; // store book cover img url
}
