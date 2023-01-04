package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.User;
import com.example.springboot.service.IBorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/borrow")
public class BorrowController {
    @Autowired
    IBorrowService service;

    @PostMapping("/save")
    public Result save(@RequestBody Borrow borrow) {
        service.save(borrow);
        return Result.success();
    }

    @PutMapping("/update")
    public Result updateByEmailAndISBN(@RequestBody Borrow borrow) {
        service.updateByEmailAndISBN(borrow);
        return Result.success();
    }

    @DeleteMapping("/delete/{email}&{isbn}")
    public Result deleteByEmailAndISBN(@PathVariable String email, @PathVariable String isbn) {
        service.deleteByEmailAndISBN(email, isbn);
        return Result.success();
    }

    @GetMapping("/{email}&{isbn}")
    public Result getByEmail(@PathVariable String email, @PathVariable String isbn) {
        Borrow borrow = service.getByEmailAndISBN(email, isbn);
        return Result.success(borrow);
    }

    @GetMapping("/page")
    public Result page(BorrowPageRequest request) {
        return Result.success(service.page(request));
    }

    @GetMapping("/list")
    public Result list() {
        List<Borrow> borrow = service.list();
        return Result.success(borrow);
    }
}
