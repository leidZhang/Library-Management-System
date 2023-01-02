package com.example.springboot.service.impl;

import com.example.springboot.controller.request.CategoryPageRequest;
import com.example.springboot.entity.Category;
import com.example.springboot.mapper.CategoryMapper;
import com.example.springboot.service.ICategoryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class CategoryService implements ICategoryService {
    @Autowired
    CategoryMapper categoryMapper;

    @Override
    public List<Category> list() {
        return categoryMapper.list();
    }

    @Override
    public Object page(CategoryPageRequest request) {
        PageHelper.startPage(request.getPageNum(), request.getPageSize());
        List<Category> categories = categoryMapper.listByCondition(request);
        return new PageInfo<>(categories);
    }

    @Override
    public void save(Category category) {
        Date date = new Date();
        category.setCDate(date);
        categoryMapper.save(category);
    }

    @Override
    public void updateByName(Category category) {
        category.setUDate(new Date());
        categoryMapper.updateByName(category);
    }

    @Override
    public Category getByName(String name) {
        return categoryMapper.getByName(name);
    }

    @Override
    public void deleteByName(String name) {
        categoryMapper.deleteByName(name);
    }
}
