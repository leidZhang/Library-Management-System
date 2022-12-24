package com.example.springboot.mapper;

import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserMapper {

    // @Select("select * from person, user")
    List<User> list();

    List<User> listByCondition(UserPageRequest userPageRequest);

    void save(User user);

    User getByEmail(String email);

    void updateByEmail(User user);

    void deleteByEmail(String email);
}
