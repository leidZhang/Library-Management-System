package com.example.springboot.service;

import com.example.springboot.controller.request.BookPageRequest;
import com.example.springboot.entity.Book;

import java.util.List;

public interface IBookService {
    List<Book> list();

    Object page(BookPageRequest request);

    Book getByISBN(String isbn);

    void save(Book book);

    void updateByISBN(Book book);

    void deleteByISBN(String isbn);
}
