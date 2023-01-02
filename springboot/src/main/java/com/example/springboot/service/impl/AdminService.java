package com.example.springboot.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.example.springboot.controller.dto.LoginDTO;
import com.example.springboot.controller.request.AdminPageRequest;
import com.example.springboot.controller.request.LoginRequest;
import com.example.springboot.controller.request.PasswordRequest;
import com.example.springboot.entity.Admin;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.AdminMapper;
import com.example.springboot.service.IAdminService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class AdminService implements IAdminService {
    private static String DEFAULT_PASS = "000000";
    private static String PASS_SALT = "random";

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
        if(StrUtil.isBlank(admin.getPasswrd())) {
            admin.setPasswrd(DEFAULT_PASS);
        }
        admin.setPasswrd(secPass(admin.getPasswrd())); // md5 encryption
        adminMapper.save(admin);
    }

    @Override
    public void deleteByEmail(String email) {
        adminMapper.deleteByEmail(email);
    }

    @Override
    public LoginDTO login(LoginRequest request) {
        request.setPassword(secPass(request.getPassword()));
        Admin admin = adminMapper.getByEmailAndPassword(request);
        if(admin == null) {
            throw new ServiceException("Wrong email or password");
        }
        if(!admin.isStatus()) {
            throw new ServiceException("This account is currently disabled, please contact administrator");
        }
        LoginDTO loginDTO = new LoginDTO();
        BeanUtils.copyProperties(admin, loginDTO);
        return loginDTO;
    }

    @Override
    public void changePass(PasswordRequest request) {
        request.setPassword(secPass(request.getPassword()));
        request.setNewPassword(secPass(request.getNewPassword()));
        adminMapper.changePass(request);
    }

    @Override
    public void resetPass(PasswordRequest request) {
        request.setNewPassword(secPass(DEFAULT_PASS));
        adminMapper.resetPass(request);
    }

    @Override
    public Admin getByEmail(String email) {
        return adminMapper.getByEmail(email);
    }

    @Override
    public void updateByEmail(Admin admin) {
        adminMapper.updateByEmail(admin);
    }

    private String secPass(String password) {
        return SecureUtil.md5(password + PASS_SALT);
    }
}
