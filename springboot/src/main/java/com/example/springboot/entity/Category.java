package com.example.springboot.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class Category {
    private Integer id;
    private String name;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date cDate;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date uDate;
    private Integer pid;
    // sub-categories
    private List<Category> children;
}
