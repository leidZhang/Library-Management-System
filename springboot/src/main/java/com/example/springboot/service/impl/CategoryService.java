package com.example.springboot.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.example.springboot.controller.request.CategoryPageRequest;
import com.example.springboot.entity.Category;
import com.example.springboot.mapper.CategoryMapper;
import com.example.springboot.service.ICategoryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class CategoryService implements ICategoryService {
    @Autowired
    CategoryMapper categoryMapper;

    @Override
    public List<Category> tree() {
        List<Category> categories = categoryMapper.tree();
        return helper(categories);
    }

    private List<Category> helper(List<Category> categories) {
        // Create parent list
        List<Category> pList = new ArrayList<>();
        for(Category category: categories) {
            if(category.getPid() == null) {
                pList.add(category);
            }
        }
        // Set children list
        for(Category pCategory: pList) {
            List<Category> children = new ArrayList<>();
            for(Category category: categories) {
                if(pCategory.getId() == category.getPid()) {
                    children.add(category);
                    pCategory.setChildren(children);
                }
            }
        }
        return pList;
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
