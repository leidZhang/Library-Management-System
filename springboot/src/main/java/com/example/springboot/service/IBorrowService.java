package com.example.springboot.service;

import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.entity.Borrow;

import java.util.List;

public interface IBorrowService {
    List<Borrow> list();

    Object page(BorrowPageRequest request);

    void save(Borrow borrow);

    Borrow getByEmailAndISBN(String email, String isbn);

    void updateByEmailAndISBN(Borrow borrow);

    void deleteByEmailAndISBN(String email, String isbn);
}
