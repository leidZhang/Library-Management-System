package com.example.springboot.mapper;

import com.example.springboot.controller.request.BookPageRequest;
import com.example.springboot.entity.Book;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {

    List<Book> list();

    List<Book> listByCondition(BookPageRequest request);

    Book getByISBN(String isbn);

    void save(Book book);

    void updateByISBN(Book book);

    void deleteByISBN(String isbn);
}
