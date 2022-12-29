package com.example.springboot.service.impl;

import com.example.springboot.controller.request.AdminPageRequest;
import com.example.springboot.entity.Admin;
import com.example.springboot.mapper.AdminMapper;
import com.example.springboot.service.IAdminService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class AdminService implements IAdminService {
    @Autowired
    AdminMapper adminMapper;

    @Override
    public List<Admin> list() {
        return adminMapper.list();
    }

    @Override
    public Object page(AdminPageRequest adminPageRequest) {
        PageHelper.startPage(adminPageRequest.getPageNum(), adminPageRequest.getPageSize());
        List<Admin> admins = adminMapper.listByCondition(adminPageRequest);
        return new PageInfo<>(admins);
    }

    @Override
    public void save(Admin admin) {
        String code = String.valueOf(new Random().nextInt(899999) + 100000); // generate random code
        admin.setPasswrd(code);
        adminMapper.save(admin);
    }

    @Override
    public void deleteByEmail(String email) {
        adminMapper.deleteByEmail(email);
    }

    @Override
    public Admin getByEmail(String email) {
        return adminMapper.getByEmail(email);
    }

    @Override
    public void updateByEmail(Admin admin) {
        adminMapper.updateByEmail(admin);
    }

}
