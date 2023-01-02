package com.example.springboot.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.UserMapper;
import com.example.springboot.service.IUserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class UserService implements IUserService {
    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> list() {
        return userMapper.list();
    }

    @Override
    public Object page(UserPageRequest userPageRequest) {
        PageHelper.startPage(userPageRequest.getPageNum(), userPageRequest.getPageSize());
        List<User> users = userMapper.listByCondition(userPageRequest);
        return new PageInfo<>(users);
    }

    @Override
    public void save(User user) {
        Date date = new Date();

        user.setUid(DateUtil.format(date, "yyyyMMdd") + Math.abs(IdUtil.fastSimpleUUID().hashCode()));
        user.setCTime(date);
        try {
            userMapper.save(user);
        } catch (DuplicateKeyException e) {
            log.error("Insertion failed: Email address: {}", user.getEmail());
            throw new ServiceException("Duplicate email address");
        }

    }

    @Override
    public User getByEmail(String email) {
        return userMapper.getByEmail(email);
    }

    @Override
    public void updateByEmail(User user) {
        user.setUTime(new Date());
        userMapper.updateByEmail(user);
    }

    @Override
    public void deleteByEmail(String email) {
        userMapper.deleteByEmail(email);
    }

}
