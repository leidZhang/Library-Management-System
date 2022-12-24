package com.example.springboot.controller.request;

import lombok.Data;

@Data
public class UserPageRequest extends BaseRequest {
    private String fname;
    private String uid;
}
