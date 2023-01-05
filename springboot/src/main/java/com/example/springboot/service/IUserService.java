package com.example.springboot.service;

import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


public interface IUserService {
    List<User> list();

    Object page(UserPageRequest userPageRequest);

    void save(User user);

    User getByEmail(String email);

    void updateByEmail(User user);

    void deleteByEmail(String email);

    void chargeUser(User user);
}
