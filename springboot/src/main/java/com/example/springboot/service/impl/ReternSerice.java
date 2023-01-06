package com.example.springboot.service.impl;

import com.example.springboot.controller.request.ReternPageRequest;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Retern;
import com.example.springboot.entity.User;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.mapper.BorrowMapper;
import com.example.springboot.mapper.ReternMapper;
import com.example.springboot.mapper.UserMapper;
import com.example.springboot.service.IReternService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class ReternSerice implements IReternService {
    private static final String RETURNED = "Returned";
    @Autowired
    ReternMapper mapper;

    @Autowired
    BookMapper bookMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    BorrowMapper borrowMapper;

    @Override
    public List<Retern> list() {
        return mapper.list();
    }

    @Override
    public Object page(ReternPageRequest request) {
        PageHelper.startPage(request.getPageNum(), request.getPageSize());
        List<Retern> retern = mapper.listByCondition(request);
        return new PageInfo<>(retern);
    }

    @Override
    public void deleteByEmailAndISBN(String email, String isbn) {
        try {
            mapper.deleteByEmailAndISBN(email, isbn);
        } catch (Exception e) {
            throw new ServiceException("Deletion failed, Please contact the administrator");
        }
    }

    @Override
    @Transactional
    public void save(Borrow borrow) {
        // get isbn and email
        String isbn = borrow.getIsbn();
        String email = borrow.getEmail();
        Integer id = borrow.getId();
        // verify the borrow record
        try {
            borrowMapper.getByEmailAndISBN(email, isbn, id);
        } catch (Exception e) {
            throw new ServiceException("Illegal Operation");
        }
        // record found, status changed in the borrow record
        borrow.setBStatus(RETURNED);
        borrowMapper.updateByEmailAndISBN(borrow);
        // book number increase
        Book book = bookMapper.getByISBN(isbn);
        book.setNumber(book.getNumber() + 1);
        bookMapper.updateByISBN(book);
        // return some credit if the book is returned before the due date
        User user = userMapper.getByEmail(email);
        LocalDateTime now = LocalDateTime.now();
        long realDuration = 0;
        if(now.isBefore(borrow.getRDate())) { // refund
            realDuration = now.until(borrow.getRDate(), ChronoUnit.DAYS) + 1;
            Integer returnCredit = Math.toIntExact(book.getCredit() * realDuration);
            user.setACredit(user.getACredit() + returnCredit); // original + payback
        } else if(now.isAfter(borrow.getRDate())) {
            realDuration = borrow.getRDate().until(now, ChronoUnit.DAYS);
            Integer chargeCredit = 2 * Math.toIntExact(book.getCredit() * realDuration); // past due penalty
            user.setACredit(user.getACredit() - chargeCredit); // original - penalty
        }
        if(user.getACredit() < 0) { // lock account if the score is negative
            user.setStatus(false);
        }
        userMapper.updateByEmail(user);
        // generate record id
        Integer max = 0;
        List<Retern> records = mapper.selectByEmailAndISBN(email, isbn);
        if(!records.isEmpty()) {
            for(Retern record: records) {
                Integer rId = record.getId();
                if(rId > max) {
                    max = rId;
                }
            }
        }
        // generate return record
        Retern retern = new Retern();
        retern.setIsbn(isbn);
        retern.setEmail(email);
        retern.setCDate(borrow.getCDate());
        retern.setDuration(borrow.getDuration());
        retern.setBStatus(RETURNED);
        retern.setRDate(borrow.getRDate());
        retern.setADate(now);
        retern.setId(max + 1);
        // upload to the database
        try {
            mapper.save(retern);
        } catch (Exception e) {
            throw new ServiceException("Return failed, please contact the administrator");
        }
    }
}
