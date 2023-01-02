package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.dto.LoginDTO;
import com.example.springboot.controller.request.AdminPageRequest;
import com.example.springboot.controller.request.LoginRequest;
import com.example.springboot.controller.request.PasswordRequest;
import com.example.springboot.entity.Admin;
import com.example.springboot.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    IAdminService adminService;

    @PostMapping("/login")
    public Result login(@RequestBody LoginRequest request) {
        return Result.success(adminService.login(request));
    }

    @PostMapping("/save")
    public Result save(@RequestBody Admin admin) {
        adminService.save(admin);
        return Result.success();
    }

    @PutMapping("/update")
    public Result updateByEmail(@RequestBody Admin admin) {
        adminService.updateByEmail(admin);
        return Result.success();
    }

    @PutMapping("/resetPass")
    public Result resetPass(@RequestBody PasswordRequest request) {
        adminService.resetPass(request);
        return Result.success();
    }

    @PutMapping("/changePass")
    public Result changePass(@RequestBody PasswordRequest request) {
        adminService.changePass(request);
        return Result.success();
    }

    @GetMapping("/{email}")
    public Result getByEmail(@PathVariable String email) {
        Admin admin = adminService.getByEmail(email);
        return  Result.success(admin);
    }

    @DeleteMapping("/delete/{email}")
    public Result deleteByEmail(@PathVariable String email) {
        adminService.deleteByEmail(email);
        return Result.success();
    }

    @GetMapping("/list")
    public Result list() {
        List<Admin> admin = adminService.list();
        return Result.success(admin);
    }

    @GetMapping("/page")
    public Result page(AdminPageRequest adminPageRequest) {
        return Result.success(adminService.page(adminPageRequest));
    }
}
