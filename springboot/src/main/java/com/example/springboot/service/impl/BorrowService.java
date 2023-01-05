package com.example.springboot.service.impl;

import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.User;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.mapper.BorrowMapper;
import com.example.springboot.mapper.UserMapper;
import com.example.springboot.service.IBorrowService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
public class BorrowService implements IBorrowService {
    @Autowired
    BorrowMapper mapper;

    @Autowired
    BookMapper bookMapper;

    @Autowired
    UserMapper userMapper;

    @Override
    public List<Borrow> list() {
        return mapper.list();
    }

    @Override
    public Object page(BorrowPageRequest request) {
        PageHelper.startPage(request.getPageNum(), request.getPageSize());
        List<Borrow> borrows = mapper.listByCondition(request);
        return new PageInfo<>(borrows);
    }

    @Override
    @Transactional
    public void save(Borrow borrow) {
        // 1. whether the user exists
        String email = borrow.getEmail();
        User user = userMapper.getByEmail(email);
        if(Objects.isNull(user)) {
            throw new ServiceException("User does not exist");
        }
        // 2. whether the book exists
        String isbn = borrow.getIsbn();
        Book book = bookMapper.getByISBN(isbn);
        if(Objects.isNull(book)) {
            throw new ServiceException("Book does not exist");
        }
        // 3. whether the user has enough credit
        Integer user_credit = user.getACredit();
        Integer book_credit = book.getCredit();
        if(user_credit < book_credit) {
            throw new ServiceException("Not enough credit on the account");
        }
        // 4. whether there is enough book
        if(book.getNumber() < 1) {
            throw new ServiceException("Insufficient quantity of the book");
        }
        // 5. 1-4 passed, proceed to borrow operation
        user.setACredit(user_credit - book_credit); // 5.1 billing
        book.setNumber(book.getNumber() - 1); // 5.1 update book number
        userMapper.updateByEmail(user); // 5.3 update user account
        bookMapper.updateByISBN(book); // 5.4 update book
        borrow.setCDate(new Date()); // 5.5 generate borrow date
        try {
            mapper.save(borrow);
        } catch (Exception e) {
            throw new ServiceException("Borrow failed, please contact the administrator");
        }
    }

    @Override
    public Borrow getByEmailAndISBN(String email, String isbn) {
        return mapper.getByEmailAndISBN(email, isbn);
    }

    @Override
    public void updateByEmailAndISBN(Borrow borrow) {
        borrow.setUDate(new Date());
        mapper.updateByEmailAndISBN(borrow);
    }

    @Override
    public void deleteByEmailAndISBN(String email, String isbn) {
        try {
            mapper.deleteByEmailAndISBN(email, isbn);
        } catch (Exception e) {
            throw new ServiceException("Deletion failed, Please contact the administrator");
        }

    }
}
