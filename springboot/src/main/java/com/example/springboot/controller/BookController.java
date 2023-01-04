package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.BookPageRequest;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.User;
import com.example.springboot.service.IBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/book")
public class BookController {
    @Autowired
    IBookService service;

    @PostMapping("/save")
    public Result save(@RequestBody Book book) {
        service.save(book);
        return Result.success();
    }

    @PutMapping("/update")
    public Result updateByISBN(@RequestBody Book book) {
        service.updateByISBN(book);
        return Result.success();
    }

    @DeleteMapping("/delete/{isbn}")
    public Result deleteByISBN(@PathVariable String isbn) {
        service.deleteByISBN(isbn);
        return Result.success();
    }

    @GetMapping("/{isbn}")
    public Result getByISBN(@PathVariable String isbn) {
        Book book = service.getByISBN(isbn);
        return Result.success(book);
    }

    @GetMapping("/list")
    public Result list() {
        List<Book> book = service.list();
        return Result.success(book);
    }

    @GetMapping("/page")
    public Result page(BookPageRequest request) {
        return Result.success(service.page(request));
    }
}
