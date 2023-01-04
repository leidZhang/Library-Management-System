package com.example.springboot.service.impl;

import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.BorrowMapper;
import com.example.springboot.service.IBorrowService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class BorrowService implements IBorrowService {
    @Autowired
    BorrowMapper mapper;

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
    public void save(Borrow borrow) {
        borrow.setCDate(new Date());
        try {
            mapper.save(borrow);
        } catch (DuplicateKeyException e) {
            log.error("Borrow failed: Email address: {}", borrow.getEmail());
            throw new ServiceException("Duplicate email address");
        } catch (Exception e) {
            log.error("Borrow failed");
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
