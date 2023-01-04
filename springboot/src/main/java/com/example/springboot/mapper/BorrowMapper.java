package com.example.springboot.mapper;

import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.entity.Borrow;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BorrowMapper {
    List<Borrow> list();

    List<Borrow> listByCondition(BorrowPageRequest request);

    void save(Borrow borrow);

    Borrow getByEmailAndISBN(String email, String isbn);

    void updateByEmailAndISBN(Borrow borrow);

    void deleteByEmailAndISBN(String email, String isbn);
}
