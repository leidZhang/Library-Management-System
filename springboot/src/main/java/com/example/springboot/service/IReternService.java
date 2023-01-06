package com.example.springboot.service;

import com.example.springboot.controller.request.ReternPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Retern;

import java.util.List;

public interface IReternService {
    List<Retern> list();

    Object page(ReternPageRequest request);

    void deleteByEmailAndISBN(String email, String isbn);

    void save(Borrow borrow);
}
