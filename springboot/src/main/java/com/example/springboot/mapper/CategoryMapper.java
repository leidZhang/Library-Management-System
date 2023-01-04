package com.example.springboot.mapper;

import com.example.springboot.controller.request.CategoryPageRequest;
import com.example.springboot.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CategoryMapper {
    List<Category> tree();

    List<Category> listByCondition(CategoryPageRequest request);

    void save(Category category);

    void updateByName(Category category);

    Category getByName(String name);

    void deleteByName(String name);
}
