package com.example.springboot.controller.request;

import lombok.Data;

@Data
public class BookPageRequest extends BaseRequest {
    private String isbn;
    private String name;
}
