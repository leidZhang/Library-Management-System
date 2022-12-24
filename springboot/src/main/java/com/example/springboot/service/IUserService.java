package com.example.springboot.service;

import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


public interface IUserService {
    List<User> list();

    Object page(UserPageRequest userPageRequest);

}
