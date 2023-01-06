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
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
public class BorrowService implements IBorrowService {
    private static final String DEFAULT_STATUS = "Borrowed";
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
        LocalDateTime now = LocalDateTime.now();
        for(Borrow borrow: borrows) {
            if(borrow.getBStatus().equals("Borrowed")) {
                LocalDateTime returnDate = borrow.getRDate();
                if(now.plusDays(1).equals(returnDate)) {
                    borrow.setNotification("about expire");
                } else if(now.equals(returnDate)) {
                    borrow.setNotification("at the due date");
                } else if(now.isAfter(returnDate)) {
                    borrow.setNotification("expired");
                } else {
                    borrow.setNotification("unexpired");
                }
                mapper.updateByEmailAndISBN(borrow);
            }
        }
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
        // 3. whether there is enough book
        if(book.getNumber() < 1) {
            throw new ServiceException("Insufficient quantity of the book");
        }
        // 4. whether the user has enough credit
        Integer userCredit = user.getACredit();
        Integer needCredit = book.getCredit() * borrow.getDuration(); // book's credit * duration
        if(userCredit < needCredit) {
            throw new ServiceException("Not enough credit on the account");
        }
        // 5. 1-4 passed, proceed to borrow operation
        user.setACredit(userCredit - needCredit); // 5.1 billing
        book.setNumber(book.getNumber() - 1); // 5.1 update book number
        userMapper.updateByEmail(user); // 5.3 update user account
        bookMapper.updateByISBN(book); // 5.4 update book
        borrow.setCDate(LocalDateTime.now()); // 5.5 generate borrow date
        borrow.setBStatus(DEFAULT_STATUS); // 5.6 set status
        // 6. Set id
        List<Borrow> records = mapper.selectByEmailAndISBN(email, isbn);
        Integer max = 0;
        if(!records.isEmpty()) {
            for(Borrow record: records) {
                Integer rId = record.getId();
                if(rId > max) {
                    max = rId;
                }
            }
        }
        borrow.setId(max + 1);
        // set expected return date
        borrow.setRDate(LocalDateTime.now().plus(borrow.getDuration(), ChronoUnit.DAYS));
        try {
            mapper.save(borrow);
        } catch (Exception e) {
            throw new ServiceException("Borrow failed, please contact the administrator");
        }
    }

    @Override
    public Borrow getByEmailAndISBN(String email, String isbn, Integer id) {
        return mapper.getByEmailAndISBN(email, isbn, id);
    }

    @Override
    public void updateByEmailAndISBN(Borrow borrow) {
        mapper.updateByEmailAndISBN(borrow);
    }

    @Override
    public void deleteByEmailAndISBN(String email, String isbn, Integer id) {
        try {
            mapper.deleteByEmailAndISBN(email, isbn, id);
        } catch (Exception e) {
            throw new ServiceException("Deletion failed, Please contact the administrator");
        }
    }
}
