package com.example.springboot.controller.request;

import lombok.Data;

@Data
public class ReternPageRequest extends BaseRequest {
    private String email;
    private String isbn;
    private String name; // book_name
    private String username;
}
