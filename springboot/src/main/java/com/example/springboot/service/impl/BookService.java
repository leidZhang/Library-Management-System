package com.example.springboot.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.example.springboot.controller.request.BookPageRequest;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.User;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.service.IBookService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class BookService implements IBookService {
    @Autowired
    BookMapper mapper;

    @Override
    public List<Book> list() {
        return mapper.list();
    }

    @Override
    public Object page(BookPageRequest request) {
        PageHelper.startPage(request.getPageNum(), request.getPageSize());
        List<Book> books = mapper.listByCondition(request);
        return new PageInfo<>(books);
    }

    @Override
    public Book getByISBN(String isbn) {
        return mapper.getByISBN(isbn);
    }

    @Override
    public void save(Book book) {
        Date date = new Date();
        book.setCDate(date);
        mapper.save(book);
    }

    @Override
    public void updateByISBN(Book book) {
        book.setUDate(new Date());
        mapper.updateByISBN(book);
    }

    @Override
    public void deleteByISBN(String isbn) {
        mapper.deleteByISBN(isbn);
    }
}
