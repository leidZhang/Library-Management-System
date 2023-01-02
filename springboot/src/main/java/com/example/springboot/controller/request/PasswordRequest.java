package com.example.springboot.controller.request;

import lombok.Data;

@Data
public class PasswordRequest {
    private String email;
    private String password;
    private String newPassword;
}
