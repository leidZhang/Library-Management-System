package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import com.example.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    IUserService userService;

    @PostMapping("/save")
    public Result save(@RequestBody User user) {
        userService.save(user);
        return Result.success();
    }

    @PostMapping("/charge")
    public Result chargeUser(@RequestBody User user) {
        userService.chargeUser(user);
        return Result.success();
    }

    @PutMapping("/update")
    public Result updateByEmail(@RequestBody User user) {
        userService.updateByEmail(user);
        return Result.success();
    }

    @DeleteMapping("/delete/{email}")
    public Result deleteByEmail(@PathVariable String email) {
        userService.deleteByEmail(email);
        return Result.success();
    }

    @GetMapping("/{email}")
    public Result getByEmail(@PathVariable String email) {
        User user = userService.getByEmail(email);
        return Result.success(user);
    }

    @GetMapping("/list")
    public Result list() {
        List<User> user = userService.list();
        return Result.success(user);
    }

    @GetMapping("/page")
    public Result page(UserPageRequest userPageRequest) {
        return Result.success(userService.page(userPageRequest));
    }
}
