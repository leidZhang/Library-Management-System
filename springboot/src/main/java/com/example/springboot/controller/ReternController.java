package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.ReternPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Retern;
import com.example.springboot.service.IReternService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/retern")
public class ReternController {
    @Autowired
    IReternService service;

    @PostMapping("/save")
    public Result save(@RequestBody Borrow borrow) {
        service.save(borrow);
        return Result.success();
    }

    @DeleteMapping("/delete/{email}&{isbn}")
    public Result deleteByEmailAndISBN(@PathVariable String email, @PathVariable String isbn) {
        service.deleteByEmailAndISBN(email, isbn);
        return Result.success();
    }

    @GetMapping("/list")
    public Result list() {
        List<Retern> retern = service.list();
        return Result.success(retern);
    }

    @GetMapping("/page")
    public Result page(ReternPageRequest request) {
        return Result.success(service.page(request));
    }
}
