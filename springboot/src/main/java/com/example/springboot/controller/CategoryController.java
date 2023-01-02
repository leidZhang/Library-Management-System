package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.CategoryPageRequest;
import com.example.springboot.entity.Category;
import com.example.springboot.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    ICategoryService categoryService;


    @PutMapping("/update")
    public Result updateByName(@RequestBody Category category) {
        categoryService.updateByName(category);
        return  Result.success();
    }

    @PostMapping("/save")
    public Result save(@RequestBody Category category) {
        categoryService.save(category);
        return Result.success();
    }

    @DeleteMapping("/delete/{name}")
    public Result deleteByName(@PathVariable String name) {
        categoryService.deleteByName(name);
        return Result.success();
    }

    @GetMapping("/{name}")
    public Result getByName(@PathVariable String name) {
        Category category = categoryService.getByName(name);
        return Result.success(category);
    }

    @GetMapping("/list")
    public Result list() {
        List<Category> category = categoryService.list();
        return Result.success(category);
    }

    @GetMapping("/page")
    public Result page(CategoryPageRequest request) {
        return Result.success(categoryService.page(request));
    }
}
