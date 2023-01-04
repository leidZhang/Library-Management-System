package com.example.springboot.service;

import com.example.springboot.controller.request.CategoryPageRequest;
import com.example.springboot.entity.Category;

import java.util.List;

public interface ICategoryService {
    List<Category> tree();

    Object page(CategoryPageRequest request);

    void save(Category category);

    void updateByName(Category category);

    Category getByName(String name);

    void deleteByName(String name);

}
